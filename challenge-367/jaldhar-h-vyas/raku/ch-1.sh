#!/bin/sh

raku -e '@*ARGS[0].comb.sort.reverse.rotate.join.say' "$@"
