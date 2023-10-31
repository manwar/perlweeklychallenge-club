#!/usr/bin/env raku
=begin comment
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 23-OCT-2023
Challenge 240 Task 02 Build Array ( Raku )
-----------------------------------
=end comment
use v6;

my @myints = ([0, 2, 1, 5, 3, 4],[5, 0, 1, 2, 3, 4]);

for (@myints) -> @mints {
    my @out = ();
    say "Input: \@ints = ",[@mints];
    loop (my $cnt = 0; $cnt < @mints.elems; $cnt++ ) {
        push(@out, @mints[@mints[$cnt]]);
    }
    say "Output: ",[@out],"\n";
}

=begin comment
-----------------------------------
SAMPLE OUTPUT

raku .\BuildArray.rk

Input: @ints = [0 2 1 5 3 4]
Output: [0 1 2 4 5 3]

Input: @ints = [5 0 1 2 3 4]
Output: [4 5 0 1 2 3]
-----------------------------------
=end comment


