#!/bin/sh

raku -e '@*ARGS.combinations(2).grep({$_.sum%%24}).elems.say' "$@"
