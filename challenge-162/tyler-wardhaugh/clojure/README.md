# c160

The Weekly Challenge — #160 — Tyler Wardhaugh

## Usage

Clojure ([installation instructions](https://clojure.org/guides/getting_started#_clojure_installer_and_cli_tools)) required for `clojure` commands; Babashka ([installation instructions](https://github.com/babashka/babashka#quickstart)) required for the `bb` commands.

Run Task #1:

    $ clojure -M:t1 N
    # ... or ...
    $ bb run task-1 N

    # Alternatively, to run it via Babashka:
    $ bb run task-1-bb N

Run Task #2:

    $ clojure -M:t2 N
    # ... or ...
    $ bb run task-2 N

    # Alternatively, to run it via Babashka:
    $ bb run task-2-bb N

Run the project's tests (which are samples from the task descriptions):

    $ clojure -T:build test
    # ... or ...
    $ bb run test

View available tasks Babashka can run:

    $ bb tasks

## License

Copyright © 2022 Tyler Wardhaugh

Distributed under the Eclipse Public License version 1.0.
