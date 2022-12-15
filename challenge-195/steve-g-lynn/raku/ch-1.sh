#!/bin/sh

raku -e '(1 .. @*ARGS[0]).grep({$_ == $_.comb.unique.join}).elems.say' $@
