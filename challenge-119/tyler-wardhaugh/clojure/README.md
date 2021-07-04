# tw.weekly.c118


The Weekly Challenge - #118 - Tyler Wardhaugh

## Usage

Clojure ([installation instructions](https://clojure.org/guides/getting_started#_clojure_installer_and_cli_tools)) required for `clojure` commands; Babashka ([installation instructions](https://github.com/babashka/babashka#quickstart)) required for the `bb` commands.

Run the project directly (shows default output from both tasks):

    $ clojure -M -m tw.weekly.c118.core
    # ... or ...
    $ bb run both

Run the project's tests (which are samples from the task descriptions):

    $ clojure -M:test:runner
    # ... or ...
    $ bb run test

Run Task #1 with input

    $ clojure -M -m tw.weekly.c118.t1 N
    # ... or ...
    $ bb run task-1 N

Run Task #2 with input:

    $ clojure -M -m tw.weekly.c118.t2
    # ... or ...
    $ bb run task-2

## Project Template

I used Sean Corfield's clj-new to generate the project template

See [seancorfield/clj-new: Generate new projects based on clj, Boot, or Leiningen Templates!](https://github.com/seancorfield/clj-new) for more information.

## License

Copyright © 2021 Tyler Wardhaugh

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
