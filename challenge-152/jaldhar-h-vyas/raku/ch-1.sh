#!/bin/sh

raku -e '@*ARGS.map({$_.split(q{,}).min}).sum.say' "$@"

