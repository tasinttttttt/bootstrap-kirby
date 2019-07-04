## Kirby bootstrap

Commands and configuration files to speed things up.

## Project

Requirements: `git, npm, sass`

Project structure

```
.
├── .editorconfig
├── .gitignore
├── Makefile
├── README.md
└── src
```

## Commands

### Compile js and sass
```sh
make
make build
```

### Compile and watch js and sass
```sh
make dev
```

### Stop js and sass watch
```sh
make stop
```

### Install Kirby
```sh
make install
```

### Uninstall Kirby
```sh
make uninstall
```

### Stop watch, delete compiled js and css files. 
```sh
make clean
make fclean
```

### Delete everything and recompile
```sh
make re
```
