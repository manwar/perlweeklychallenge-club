#!/bin/sh

raku -e '@*ARGS.combinations(1..@*ARGS.elems).map({$_.max**2*$_.min}).sum.say' "$@"
