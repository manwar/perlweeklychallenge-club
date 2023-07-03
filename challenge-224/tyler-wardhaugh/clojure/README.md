# c223

The Weekly Challenge — #223 — Tyler Wardhaugh

## Usage

Clojure ([installation instructions](https://clojure.org/guides/getting_started#_clojure_installer_and_cli_tools)) required for `clojure` commands; Babashka ([installation instructions](https://github.com/babashka/babashka#quickstart)) required for the `bb` commands.

Run Task #1:

    $ clojure -M:t1 N
    # ... or ...
    $ bb run task-1 N

Run Task #2:

    $ clojure -M:t2 COLL
    # ... or ...
    $ bb run task-2 COLL

    # Alternatively, to run it via Babashka:
    $ bb run task-2-bb COLL

Run the project's tests (which are samples from the task descriptions):

    $ clojure -T:build test
    # ... or ...
    $ bb run test

View available tasks Babashka can run:

    $ bb tasks

## License

Copyright © 2023 Tyler Wardhaugh

Distributed under the Eclipse Public License version 1.0.
