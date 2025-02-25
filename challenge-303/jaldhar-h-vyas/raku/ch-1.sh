#!/bin/sh

raku -e '@*ARGS.permutations.map({$_[0..2].join.Int}).grep({$_.chars==3&&$_%%2}).unique.sort.say' "$@"

