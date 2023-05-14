# c216

The Weekly Challenge — #216 — Tyler Wardhaugh

## Usage

Clojure ([installation instructions](https://clojure.org/guides/getting_started#_clojure_installer_and_cli_tools)) required for `clojure` commands; Babashka ([installation instructions](https://github.com/babashka/babashka#quickstart)) required for the `bb` commands.

Run Task #1:

    $ clojure -M:t1 REG COLL
    # ... or ...
    $ bb run task-1 REG COLL

    # Alternatively, to run it via Babashka:
    $ bb run task-1-bb REG COLL

Run Task #2:

    $ clojure -M:t2 WORD COLL
    # ... or ...
    $ bb run task-2 WORD COLL

    # Alternatively, to run it via Babashka:
    $ bb run task-2-bb WORD COLL

Run the project's tests (which are samples from the task descriptions):

    $ clojure -T:build test
    # ... or ...
    $ bb run test

View available tasks Babashka can run:

    $ bb tasks

## License

Copyright © 2023 Tyler Wardhaugh

Distributed under the Eclipse Public License version 1.0.
