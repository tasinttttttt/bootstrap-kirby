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
npm install
```

#### Second step:
Create `www/assets` folder.

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
