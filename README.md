## Kirby 3 bootstrap

Commands and configuration files to speed things up.

## Project

Requirements: `git, node`

Project structure

```
.
├── ...
├── rollup.config.js # Configuration
├── www # Website content
└── src # Source files
```

## Installation

#### First step:

```sh
git clone --recurse-submodules --remote-submodules
npm install
```

If you wish to merge kirby into your repo:

```
# 1. Remove reference to www submodule in .gitmodules and .git/config
vim .git/config
vim .gitmodules

# 2. Remove the submodule from cache
git rm --cached www

# 3. Add www as part of the repo
git add www
git commit -m "Merge www"
```

#### Second step:

Add `<link rel="stylesheet" type="text/css" href="assets/bundle.css">` to the head part of your template.

And `<script src="assets/bundle.js"></script>` to your template.

## Commands

#### Development starts a php server `http://localhost:8000`
```sh
npm run dev
```

#### Build
```sh
npm run build
```
