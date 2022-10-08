# Challenge #185

The Weekly Challenge — #185 — Tyler Wardhaugh

## Requirements

[Fennel](https://fennel-lang.org/) required to run the code. Fennel itself requires [Lua](https://lua.org/). The test suite requires [busted](https://lunarmodules.github.io/busted/) be installed.

[Babashka](https://github.com/babashka/babashka) required to run `bb` commands.

Fennel does not currently have a convention for source files to be both modules and scripts (variously referred to by executable libraries, modulinos, and scripted main), so tasks are implemented as modules which can be run in several ways.

## Usage

Run Task #1:

    $ bb task-1 N
    # ... or ...
    $ fennel -e '((. (require :t1) :main))' N

Run Task #2:

    $ bb task-2
    # ... or ...
    $ fennel -e '((. (require :t2) :main))'

Compile all Fennel files to Lua:

    $ bb compile

Run the project's tests (which are samples from the task descriptions):

    $ bb test

View available tasks Babashka can run:

    $ bb tasks

## License

Copyright © 2022 Tyler Wardhaugh

Distributed under the Eclipse Public License version 1.0.
