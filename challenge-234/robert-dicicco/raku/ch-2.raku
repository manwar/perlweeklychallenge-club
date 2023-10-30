#!/usr/bin/env raku
=begin comment
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-14
Challenge 234 Task 2 Unequal Triplets ( Raku )
-----------------------------------
=end comment

my @myints = ([4, 4, 2, 4, 3],[1, 1, 1, 1, 1],[4, 7, 1, 10, 7, 4, 1, 1]);
for (@myints) -> @ints {
    my $cnt = 0;
    say "Input: \@ints = ",@ints;
    for @ints.combinations(3) -> @i {
        if ((@i[0] != @i[1]) && (@i[1] != @i[2]) && (@i[0] != @i[2])) {
            $cnt++;
        }
    }
    say "Output: $cnt\n";
}

=begin comment
-----------------------------------
SAMPLE OUTPUT
raku .\UnequalTriplets.rk

Input: @ints = [4 4 2 4 3]
Output: 3

Input: @ints = [1 1 1 1 1]
Output: 0

Input: @ints = [4 7 1 10 7 4 1 1]
Output: 28
-----------------------------------
=end comment



