#!/bin/sh

raku -e '@*ARGS.map({$_.comb.sort.join}).unique.elems.say' "$@"
