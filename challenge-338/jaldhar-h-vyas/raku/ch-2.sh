#!/bin/sh

raku -e '(@*ARGS[0].split(q{,})X@*ARGS[1].split(q{,})).map({($_[0]-$_[1]).abs}).max.say' "$@"