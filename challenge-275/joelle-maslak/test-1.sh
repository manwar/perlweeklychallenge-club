#!/bin/bash
set -e

test_it() {
    echo -n $1 "'$2'" $3 ...
    OUT=$($1 "$2" "$3")
    if [ "$OUT" == "$4" ] ; then
        echo "ok"
    else
        echo "INCORRECT ($OUT)"
    fi
}

test_combo() {
    test_it "$1" "Perl Weekly Challenge" la 0
    test_it "$1" "Perl and Raku" a 1
    test_it "$1" "Well done Team PWC" lo 2
    test_it "$1" "The joys of polyglottism" T 2
}

do_it() {
    test_combo "perl perl/ch-1.pl"
    test_combo "raku raku/ch-1.raku"
}

do_it "$@"


