#!/bin/sh

raku -e 'say q{"},(@*ARGS[0].comb.Mix∖@*ARGS[1].comb.Mix).keys.join,q{"}' "$@"