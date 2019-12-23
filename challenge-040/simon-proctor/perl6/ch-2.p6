#!/usr/bin/env perl6

use v6.d;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Given a list of values and a list of sorting indicies
#| Return the list with the requests indicies sorted
sub MAIN (
    Str() $list, #= Seperated list
    Str() $indices, #= List of indicies
    Str() :s(:$sep) where
            {
                $list ~~ m/^(<[0..9]>+) + % $sep $/ &&
                $indices ~~ m/^(<[0..9]>+) + % $sep $/
            } = ',', #= Optional seperator. Defaults to ','
) {
    my @list = $list.split($sep).map(*.Int);
    my @indices = $indices.split($sep).map(*.Int);
    @list[@indices] = @list[@indices].sort;
    say @list.join($sep);
}
