#!/bin/sh

raku -e 'say %(@*ARGS[0].comb.permutations.map({$_.join}).sort.unique.kv.reverse){@*ARGS[0]}+1' "$@"
