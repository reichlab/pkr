# pkr

Convenience wrapper around [packrat](https://rstudio.github.io/packrat/).

## Install

- Put `pkr` somewhere in your `PATH` or just run the following
  ```sh
  curl -o pkr-in "https://raw.githubusercontent.com/lepisma/pkr/master/install.sh" && bash pkr-in && rm pkr-in
  ```

- Add `~/.pkr/bin` to `PATH`

## Command line

```sh
Usage:
  pkr init
  pkr (in | install) [<inpkg>...] [--global]
  pkr (rm | remove) <rmpkg>... [--global]
  pkr status
  pkr clean
  pkr test
  pkr lint
  pkr create <script>
  pkr save <script>
  pkr -h | --help
  pkr -v | --version

Arguments:
  init             Initialize packrat project
  in, install      Install packages
  rm, remove       Remove packages
  status           Show installed packages
  clean            Remove unused packages
  test             Run tests
  lint             Lint *.R files
  create           Create a runnable R script stub with docopt
  save             Save script in pkr bin

Options:
  --global         Use global package installation location
  -h --help        Print this help
  -v --version     Show version number
```
