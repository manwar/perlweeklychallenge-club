#!/bin/sh

raku -e '@*ARGS.combinations(4).map({.permutations.map({$_[0]*$_[1]-$_[2]*$_[3]}).max}).max.say' "$@"