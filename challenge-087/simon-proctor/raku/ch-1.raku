#!/usr/bin/env raku

use v6;

sub infix:<olt> (\a,\b) is assoc<chain> is pure { b == a+1 };

#| Given a list of integers return the longest list of sequential values or 0
sub MAIN(
    *@N where { $_.all ~~ Int } #= List of integers
) {
    my @l = @N.combinations().map( *.sort ).reverse.grep( -> @l { [olt] @l } ).first;
    say @l.elems >= 2 ?? @l.join(", ") !! 0;
}
