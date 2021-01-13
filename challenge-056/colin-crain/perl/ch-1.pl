#! /opt/local/bin/perl
#
#       diffickult.pl
#
#       PWC 56 - TASK #1
#         Diff-K
#             You are given an array @N of positive integers (sorted) and
#             another non negative integer k.
#
#             Write a script to find if there exists 2 indices i and j such that
#             A[i] - A[j] = k and i != j.
#
#             It should print the pairs of indices, if any such pairs exist.
#
#             Example:
#
#                 @N = (2, 7, 9)
#                 $k = 2
#             Output : 2,1
#
#         method:
#             Given that
#                 ∀ n:
#                     A[n] > 0
#                     A[n+1] >= A[n]
#                 k >= 0
#
#             And the required truths
#
#                 A[i] - A[j] = k
#                 i != j
#
#             To be true, A[i] > k
#                         A[j] <= A[i]
#
#             which allows us to limit the search space somewhat for a brute
#             force attack on the problem. In fact, because A[j] = A[i] - k, we
#             only need to iterate over the possible i range and then can use a
#             hash lookup for the second part of the search. Note that we can't
#             outright assume that j < i because there exists the case where
#             A[j] = A[i] and j > i. In general, because we allow duplicate
#             values, there can exist multiple j solutions for a given i; we use
#             use a cascading grep filter to produce an array of results for
#             each i in the loop.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $k = shift @ARGV // 24;

my @input;
push @input, int(rand(50)) for (1..20);
@input = sort { $a <=> $b } @input;

my @indices = (0..scalar @input - 1);
my @output;

my @is =  grep { $input[$_] > $k } @indices;

for my $i ( @is ) {
    ## for each $i we can do a lookup and see whether any values $input[$j] = $input[$i] - $k exist
    ## we need to make allowances that adjacent multiple indices may hold equal values
    my @js = grep {    $input[$_] <= $input[$i]                         ## A[j] <= A[i]
                    && $input[$_] == $input[$i] - $k                    ## A[j] = A[i] - k
                    && $_ != $i                         } @indices;     ## i != j
    for my $j ( @js ) {
        push @output, [ $i, $j ];
    }
}

## output report
##
say "input\n-----\n";
say ' array: ', join ', ', @input;

say "target: $k";
say '';

say "solutions\n---------\n";
for (@output) {
    my ( $i, $j) = $_->@*;
    printf "i = %2d, j = %-2d --> %2d - %-2d = %d\n", $i, $j, $input[$i], $input[$j], $k;
}
