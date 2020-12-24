#!/usr/bin/env perl6
use v6;

# run as <script> <cubic board edge length> or just <script> to default to a 2x2x2 board
# returns ever-larger lists of queen coordinates, stopping when it's found a longest one
# backtracks, so slow!

sub dslw(@a,@b) { (@a Z- @b).map(&abs).unique == 1 || ((@a Z- @b).map(&abs).unique == 2 && (@a Z- @b).grep(0).Bool) }

sub allwd($n,@state) { ((^$n)X(^$n)X(^$n)).grep( -> @a { ! dslw(@a,@state.any) }) }

my @sol=();
sub solns($n,@state) {
    (! allwd($n,@state)) && @state.elems > @sol.elems && do { @sol = @state; say @sol; return };
    for (allwd($n,@state)) -> @a { solns($n,(@a,|@state)) }
}

solns((@*ARGS) ?? (@*ARGS[0].Int) !! 2, ());
