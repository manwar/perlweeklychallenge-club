#!/usr/bin/env raku
=begin comment
------------------------------------------
AUTHOR: Robert DiCicco
DATE  ; 2023-09-18
Challenge 235 Task 02 Duplicate Zaroes ( Raku )
------------------------------------------
=end comment
use v6;

my @myints = ([1, 0, 2, 3, 0, 4, 5, 0],[1, 2, 3],[0, 3, 0, 4, 5]);

for (@myints) -> @mints {
    say  "Input: \@ints = ",@mints;
    my @seen = ();
    my $len = @mints.elems - 1;
    for (@mints) -> $x {
        if $x != 0 {
            @seen.push: $x;
        } else {
            @seen.push: 0;
            @seen.push: 0;
        }
    }
    say "Output: [@seen[0..$len]]\n";
}

=begin comment
------------------------------------------
SAMPLE OUTPUT
raku .\DuplicateZeros.rk

Input: @ints = [1 0 2 3 0 4 5 0]
Output: [1 0 0 2 3 0 0 4]

Input: @ints = [1 2 3]
Output: [1 2 3]

Input: @ints = [0 3 0 4 5]
Output: [0 0 3 0 0]
------------------------------------------
=end comment


