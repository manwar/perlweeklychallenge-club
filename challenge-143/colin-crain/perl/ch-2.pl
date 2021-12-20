#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#     stealthy.pl
#
#     Stealthy Number
#     Submitted by: Mohammad S Anwar
#     You are given a positive number, $n.
# 
#     Write a script to find out if the given number is Stealthy Number.
# 
#     A positive integer N is stealthy, if there exist positive integers a,
#     b, c, d such that a * b = c * d = N and a + b = c + d + 1.
# 
#     Example 1
#     
#         Input: $n = 36
#         Output: 1
# 
#         Since  36 =     4 (a) * 9 (b) = 6 (c) * 6 (d) 
#                 and     4 (a) + 9 (b) = 6 (c) + 6 (d) + 1.
# 
#     Example 2
#     
#         Input: $n = 12
#         Output: 1
# 
#         Since           2 * 6 = 3 * 4 
#                 and     2 + 6 = 3 + 4 + 1
#     
#     Example 3
#     
#         Input: $n = 6
#         Output: 0
# 
#         Since           2 * 3 = 1 * 6 
#                     but 2 + 3 != 1 + 6 + 1
#                     
#         method:
#             What an unusual request for sn unusual mathematical
#             relationship.
# 
#             In any case the first equality involves pairs of values that
#             multiply to produce the target, so they must, looked at
#             inversely, be factors of the target. So, pairs of factors,
#             not necessarily unique, such that the sum of one pair winds
#             up not equal but adjacent to the sum of the other, only
#             differing by 1. 

#             I have noticed before when examining lists of factors that
#             the center value, if present, is the square root, of course,
#             as every value less than the root will have a corresponding
#             factor above the root to pair with to produce the target
#             product. Furthermore, the difference between the furthest
#             pair, the target itself and 1, the universal factor the
#             identity pairs with, is maximal among the groups, at the
#             value of the target minus 1. In the center, the root minus
#             it's pair, the root again, is minimal at 0, as any number is
#             equal to itself.
# 
#             Between the two extremes we have an increasing set of deltas
#             as we diverge from the center point or center pair, with the
#             difference always increasing. As the delta, the change, in
#             this increase is always positive, there can only be one set
#             ot two pairs where the diference between the two differ by 1.
#             And again, the difference of 1 is itself a minimum for tow
#             pairs, as even if one of the pairs consists of the square
#             root, with difference 0, the other cannot have difference 0
#             as well and a minimal increase of 1 increased the total delta
#             to 1 as well.
# 
#             Thus if a number is stealthy, the stealthy pair of factor
#             pairs will always be those closest to the root and those
#             next-further afield.
# 
#             All of this is observational: I examined lists of factors and
#             their sums and deduced the structure. To do this I had to
#             produce the lists of factor sums, and isolate those that led
#             to stealthy numbers. I found that project more rewarding to
#             examine so that is what I'm presenting: the stealthy numbers
#             between 1 and 10_000, with the list of factor sums between a
#             factor and its complement. At the bottom of each list are the
#             stealthy pairings.
# 
#             The sequence of stealthy numbers:
#             4,12,24,36,40,60,72,84,112,120,144,180,220,240,252,264,312,336,360,364,400,420,432,480, ...
#             
#             can be found in the OEIS as sequence:
#             A072389		Numbers of the form x*(x+1) * y*(y+1) 
#                           ("bipronics") with x and y nonnegative integers.

#             which is quite interesting, if not immediately illuminating.
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub nd_brute ( $num, @div ) {
    $num % $_ or push @div, $_ for 2..$num/2 ;    
    return 1, @div, $num;
}


my @seq;

for my $num ( 1..10000)
{    
    my @facts = nd_brute( $num );
    my $res = stealthy_sum_pairs( @facts );
    defined $res
        ? say $res
        : next;
    push @seq, $num;
}

say "\n", "sequence of stealthy numbers:";
say join ",", @seq;

sub stealthy_sum_pairs ( @f ) {
    my $out = "$f[-1] :\n\tfactors: @f\n";
    my $prev = 0;
    while ( @f ) {
        my ($l, $r);
        $l = shift @f;
        $r = pop @f || $l;
        $out .= join '', "\t\t", "$l + $r = ", $l + $r, "\n";
        return "$out" if $l + $r == $prev - 1;
        $prev = $l + $r;
    }
    return;

}


 
