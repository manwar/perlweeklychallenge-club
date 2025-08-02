#!/bin/sh

raku -e '(@*ARGS.sum-@*ARGS.map({$_.comb.sum}).sum).abs.say' "$@"