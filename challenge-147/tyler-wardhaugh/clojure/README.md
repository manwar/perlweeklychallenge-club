# c146

The Weekly Challenge — #146 — Tyler Wardhaugh

## Usage

Clojure ([installation instructions](https://clojure.org/guides/getting_started#_clojure_installer_and_cli_tools)) required for `clojure` commands; Babashka ([installation instructions](https://github.com/babashka/babashka#quickstart)) required for the `bb` commands.

Run Task #1 (implemented with a sieve):

    $ clojure -M:t1
    # ... or ...
    $ bb run task-1

    # Alternatively, to run it via Babashka:
    $ bb run task-1-bb

Run Task #1b (implemented using JVM's BigInteger library):

    $ clojure -M:t1b
    # ... or ...
    $ bb run task-1b

    # Alternatively, to run it via Babashka:
    $ bb run task-1b-bb

Run Task #2 with input:

    $ clojure -M:t2 M
    # ... or ...
    $ bb run task-2 M

    # Alternatively, to run it via Babashka:
    $ bb run task-2-bb

Run the project's tests (which are samples from the task descriptions):

    $ clojure -T:build test
    # ... or ...
    $ bb run test

View available tasks Babashka can run:

    $ bb tasks

## License

Copyright © 2022 Tyler Wardhaugh

Distributed under the Eclipse Public License version 1.0.
