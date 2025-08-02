#!/bin/sh

raku -e 'my ($k, @ints)=@*ARGS; say sum @ints[ (0 .. @ints.elems-1).grep({$_.base(2).comb.sum == $k}) ];' $@
