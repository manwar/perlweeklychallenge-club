#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       i-cant-even.pl
#
#       Most Frequent Even
#         Submitted by: Mohammad S Anwar
#         You are given a list of numbers, @list.
# 
#         Write a script to find most frequent even numbers in the list. In
#         case you get more than one even numbers then return the smallest
#         even integer. For all other case, return -1.
# 
#         Example 1
#             Input:  @list = (1,1,2,6,2)
#             Output: 2 as there are only 2 even numbers 2 and 6 and of
#                     those 2 appears the most.
# 
#         Example 2
#             Input:  @list = (1,3,5,7)
#             Output: -1 since no even numbers found in the list
# 
#         Example 3
#             Input:  @list = (6,4,4,6,1)
#             Output: 4 since there are only two even numbers 4 and 6. They
#                     both appears the equal number of times, so pick the
#                     smallest.
# 
#       Analysis
# 
#         First things first, let's talk terms. We are being specifically
#         asked here for the  most frequent even numbers, which seems clear
#         enough, and later on we are given a secondary qualifier to decide
#         between even numbers of equal frequency. The wording of the
#         description leaves the "of the most frequently found" implicit,
#         but this is clarified in example 3.
# 
#         So to rephrase: count the incidence of the even digits — 2, 4, 6,
#         8, and by convention 0 — and return the digit with the highest
#         frequency, or, in the case of multiple equally frequent digits
#         sharing the maximum, the smallest value.
# 
#         Sound good? 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub even_more (@list) {
    my %freq;
    my $max = 0;
    for ( grep { !( $_ % 2) } @list ) {
        $freq{$_}++;
        $freq{$_} > $max and $max = $freq{$_};
    }
  
    my @most = grep { $freq{$_} == $max } sort {$a<=>$b} keys %freq;
    return scalar @most 
        ? $most[0]
        : -1        ;
}


use Test::More;

    is even_more( 1,1,2,6,2 ),      2, 'ex-1';
    is even_more( 1,3,5,7   ),     -1, 'ex-2';
    is even_more( 6,4,4,6,1 ),      4, 'ex-3';
    is even_more( 6,7,6,9,4,1,4,3,2,5,2,7,4,9,6,1 ),  4, 'sixes and fours at 3';
    is even_more( 1,3,5,7,-2   ),  -2, 'negitives?';
    is even_more( -6,4,4,-6,1 ),   -6, 'more negatives';


done_testing();
