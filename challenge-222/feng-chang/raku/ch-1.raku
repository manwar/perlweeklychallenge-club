#!/bin/env raku

unit sub MAIN(*@N where @N.all > 0);

@N = +«@N;
my @M = @N.sort;

put (^+@N).grep({ @N[$_] == @M[$_] }).elems;
