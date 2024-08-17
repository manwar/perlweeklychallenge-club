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
    test_it "$1" "I love perl" "Imaa ovelmaaa erlpmaaaa"
    test_it "$1" "Perl and Raku are friends" "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
    test_it "$1" "The Weekly Challenge" "heTmaa eeklyWmaaa hallengeCmaaaa"
}

do_it() {
    test_combo "perl perl/ch-1.pl"
    test_combo "raku raku/ch-1.raku"
}

do_it "$@"


