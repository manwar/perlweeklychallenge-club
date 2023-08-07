#!/usr/bin/env raku
use Test;

is lexicographic-order(<abc bce cae>), 1;
is lexicographic-order(<yxz cba mon>), 2;

sub lexicographic-order(*@a)
{
    @a.map({ so any ([lt] .comb), ([gt] .comb) })
      .grep({ not .so })
      .elems
}
