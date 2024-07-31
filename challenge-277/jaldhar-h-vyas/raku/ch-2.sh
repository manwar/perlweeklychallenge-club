#!/bin/sh

raku -e '@*ARGS.unique.combinations(2).grep({ 0 < ($_[0] - $_[1]).abs < $_.min}).elems.say' "$@"
