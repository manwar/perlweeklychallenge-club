#!/bin/sh

raku -e '@*ARGS.map({$_.comb.unique.sort.join}).combinations(2).grep({@$_[0]eq@$_[1]}).elems.say' "$@"
