URL=localhost:8888
JS_PROCESSOR = npx rollup
CSS_PROCESSOR = sass
PHP_SERVER = php -S ${URL} 

SRC_FOLDER =./src
BUILD_FOLDER = ./www
DEST_FOLDER = ${BUILD_FOLDER}/assets
VAR_FOLDER =./var

JS_SOURCE =${SRC_FOLDER}/js/index.js
CSS_SOURCE = ${SRC_FOLDER}/css

JS_COMPILED = ${DEST_FOLDER}/bundle.js
CSS_COMPILED = ${DEST_FOLDER}/style

UTILITY_PROCESSES = ${VAR_FOLDER}/.processes.pid
UTILITY_ISWATCHING = ${VAR_FOLDER}/.is_watching
UTILITY_JS_LOG = ${VAR_FOLDER}/log_js.log
UTILITY_CSS_LOG = ${VAR_FOLDER}/log_sass.log
UTILITY_PHP_LOG = ${VAR_FOLDER}/log_php.log

all: build

build: 
	@ echo "\n  Compiling js and css to \033[1m${DEST_FOLDER}\033[0m"
	@ ${JS_PROCESSOR} ${JS_SOURCE} --file ${JS_COMPILED} --format iife
	@ ${CSS_PROCESSOR} ${CSS_SOURCE}:${CSS_COMPILED}

dev: 
	@ test -d ${VAR_FOLDER} && echo "\n  \033[2m${VAR_FOLDER} is set\033[0m" || (echo "\n  \033[2mCreating ${VAR_FOLDER}\033[0m" && mkdir ${VAR_FOLDER}) 
	@ nohup ${JS_PROCESSOR} ${JS_SOURCE} --file ${JS_COMPILED} --format iife -w > ${UTILITY_JS_LOG} 2>&1 & (test -f ${UTILITY_PROCESSES} && (echo $$! >> ${UTILITY_PROCESSES}) || (echo $$! > ${UTILITY_PROCESSES}))
	@ nohup ${CSS_PROCESSOR} --watch ${CSS_SOURCE}:${CSS_COMPILED} > ${UTILITY_CSS_LOG} 2>&1 & echo $$! >> ${UTILITY_PROCESSES}
	@ test -d ${BUILD_FOLDER} && (cd ${BUILD_FOLDER}; (nohup ${PHP_SERVER} > ../${UTILITY_PHP_LOG} 2>&1 & echo $$! >> ../${UTILITY_PROCESSES} && echo "  Serving at \033[96m${URL}\033[0m")) || echo "  \033[2mNo ${BUILD_FOLDER}\032[0m folder, not starting the server"
	@ touch ${UTILITY_ISWATCHING}
	@ echo "  \033[96mWatching js and css"

stop:
	@ echo "\n  Stopping js and css watch..."
	@ test -f ${UTILITY_ISWATCHING} && while read line; do kill $$line;done < ${UTILITY_PROCESSES} || echo "  \033[2mWas not watching\033[0m" 
	@ echo "  \033[92mDone!\033[0m"

install:
	@ echo "  Install Kirby? [y/n]";\
	read answer; \
	[[ "$$answer" != "$${answer#[Yy]}" ]] && git clone https://github.com/getkirby/plainkit.git www || echo "  Ok, nothing to do here."
	@ echo "  \033[92mDone!\033[0m"

uninstall:
	@ echo "  Uninstall Kirby? [y/n]";\
	read answer; \
	[[ "$$answer" != "$${answer#[Yy]}" ]] && rm -rf ${BUILD_FOLDER} || echo "  Ok, nothing to do here."
	@ echo "  \033[92mDone!\033[0m"

clean: stop 
	@ echo "\n  Project clean..."
	@ rm -rf ${JS_COMPILED} ${CSS_COMPILED}
	@ rm -rf ${VAR_FOLDER}
	@ echo "  \033[92mDone!\033[0m"

fclean: stop
	@ echo "\n  Project fclean..."
	@ rm -rf ${JS_COMPILED} ${CSS_COMPILED}
	@ rm -rf ${VAR_FOLDER}
	@ echo "  \033[92mDone!\033[0m"

re: fclean all

.PHONY: all clean fclean
