#!/bin/sh

raku -e '@*ARGS.combinations(2).grep({$_[0] eq $_[1].flip}).elems.say' "$@"