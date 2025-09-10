#!/bin/sh

raku -e '@*ARGS.map({$_.split(q{,}).sum}).max.say' "$@"