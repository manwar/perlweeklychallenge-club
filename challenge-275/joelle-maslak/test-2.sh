#!/bin/bash
set -e

test_it() {
    echo -n $1 $2 ...
    OUT=$($1 $2)
    if [ "$OUT" == "$3" ] ; then
        echo "ok"
    else
        echo "INCORRECT ($OUT)"
    fi
}

test_combo() {
    test_it "$1" "a1c1e1" "abcdef"
    test_it "$1" "a1b2c3d4" "abbdcfdh"
    test_it "$1" "b2b" "bdb"
    test_it "$1" "a16z" "abgz"
}

do_it() {
    test_combo "perl perl/ch-2.pl"
    test_combo "raku raku/ch-2.raku"
}

do_it "$@"


