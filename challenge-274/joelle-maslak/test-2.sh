#!/bin/bash
set -e

#
# Copyright (C) 2024 Joelle Maslak
# All Rights Reserved - See License
#

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
    test_it "$1" "[ [12, 11, 41], [15, 5, 35] ]" "[36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]"
    test_it "$1" "[ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]" "[0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59]"
}

do_it() {
    test_combo "perl perl/ch-2.pl"
    test_combo "raku raku/ch-2.raku"
}

do_it "$@"


