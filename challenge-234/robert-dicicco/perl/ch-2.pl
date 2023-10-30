#!/usr/bin/env perl
=begin comment
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-14
Challenge 234 Task 2 Unequal Triplets ( Perl )
-----------------------------------
=cut

use v5.38;
use Algorithm::Combinatorics qw(permutations combinations);

my @myints = ([4, 4, 2, 4, 3],[1, 1, 1, 1, 1],[4, 7, 1, 10, 7, 4, 1, 1]);

foreach my $i (@myints) {
    say "Input: \@ints = [@$i]";
    my $cnt = 0;
    my $iter = combinations($i, 3);
    while (my $c = $iter->next) {
            if ((@$c[0] != @$c[1]) && (@$c[1] != @$c[2]) && (@$c[0] != @$c[2])){
                $cnt++;
            }
    }
    say "Output: $cnt\n";
}

=begin comment
-----------------------------------
SAMPLE OUTPUT
perl .\UnequalTriplets.pl

Input: @ints = [4 4 2 4 3]
Output: 3

Input: @ints = [1 1 1 1 1]
Output: 0

Input: @ints = [4 7 1 10 7 4 1 1]
Output: 28
-----------------------------------
=cut


