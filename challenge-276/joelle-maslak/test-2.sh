#!/bin/bash
set -e

test_it() {
    echo -n $1 $2 ...
    OUT=$($1 "$2")
    if [ "$OUT" == "$3" ] ; then
        echo "ok"
    else
        echo "INCORRECT ($OUT)"
    fi
}

test_combo() {
    test_it "$1" "(1, 2, 2, 4, 1, 5)" 4
    test_it "$1" "(1, 2, 3, 4, 5)" 5
}

do_it() {
    test_combo "perl perl/ch-2.pl"
    test_combo "raku raku/ch-2.raku"
}

do_it "$@"


