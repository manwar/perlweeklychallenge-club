#!/bin/bash
set -e

test_it() {
    echo -n $1 "'$2'" ...
    OUT=$($1 "$2")
    if [ "$OUT" == "$3" ] ; then
        echo "ok"
    else
        echo "INCORRECT ($OUT)"
    fi
}

test_combo() {
    test_it "$1" "(12, 12, 30, 24, 24)" 2
    test_it "$1" "(72, 48, 24, 5)" 3
    test_it "$1" "(12, 18, 24)" 0
}

do_it() {
    test_combo "perl perl/ch-1.pl"
    test_combo "raku raku/ch-1.raku"
}

do_it "$@"


