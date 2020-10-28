#! /opt/local/bin/perl5.26
#
#       flip-the-pain-away.pl
# 
#         TASK #2 › Flip Array
#         Submitted by: Mohammad S Anwar
#             You are given an array @A of positive numbers.
# 
#             Write a script to flip the sign of some members of the given array
#             so that the sum of the all members is minimum non-negative.
# 
#             Given an array of positive elements, you have to flip the sign of
#             some of its elements such that the resultant sum of the elements
#             of array should be minimum non-negative(as close to zero as
#             possible). Return the minimum no. of elements whose sign needs to
#             be flipped such that the resultant sum is minimum non-negative.
# 
#             Example 1:
#                 Input: @A = (3, 10, 8)
#                 Output: 1
#             Explanation:
#                 Flipping the sign of just one element 10 gives 
#                 the result 1 i.e. (3) + (-10) + (8) = 1
#         
#             Example 2:
#                 Input: @A = (12, 2, 10)
#                 Output: 1
#             Explanation:
#                 Flipping the sign of just one element 12 gives 
#                 the result 0 i.e. (-12) + (2) + (10) = 0
#
#           method:
#                 this task is remarkably hairy. We are given not one but two
#                 minima to consider, first to land closest to zero, and
#                 secondarily to do this with a minimum of movement. I believe a
#                 careful reading of the text bears out this ordering.
# 
#                 Obviously one factor in play here is the sum of all the
#                 elements. However when the sign of one element is flipped,
#                 that now-negitive value is not only applied to the sum, but
#                 the positive value previously applied can no longer count as
#                 well, giving a 2-fold effect on the total.
# 
#                 The fact that the end goal of a sum of 0 is paramount makes
#                 the number of elements to be negated uncertain. If the goal
#                 cannot be completely achieved with a single flip, we will need
#                 to consider all other possibile combinations of flips before
#                 declaring that target to be impossible. This fact remains true
#                 as the goalposts are moved, so we will need to keep track of
#                 the smallest result calcuable from flipping a set number of
#                 digits as we go, along with how we obtained that result.
#                 
#   
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use Algorithm::Combinatorics qw( combinations );
use List::Util qw( sum first);

## ## ## ## ## MAIN:

my @arr = map { (int rand 1000)  } (1..20);
my $base_sum = sum @arr;
my @results;

for my $k ( 1..@arr ) {     ## for 1,2,3... numbers flipped
    
    my $min = $base_sum;
    my $pick;
    
    ## make sets of nCk combinations of elements
    my $iter = combinations(\@arr, $k);
    while (my $c = $iter->next) {
    
        my $new_sum = $base_sum - 2 * sum $c->@*;
        if ( $new_sum >= 0 and $new_sum < $min ) {
            $min = $new_sum;
            $pick = $c;
        }  
    }

    ## @results is array of minimum totals as indexes holding a list of the
    ## flips that create it, set with first instance of that minimum so shorter
    ## lengths will populate first
    $results[$min] ||= $pick;
    
    last if $min == 0;   ## we cannot do better than 0; we are done
}

my $min_sum = first { defined $results[$_] } (0..$#results);
my @neg =  $results[$min_sum]->@*;
my @pos = @arr;

for my $n (@neg) {
    my $idx =  first { $pos[$_] == $n } (0..$#pos);
    splice(@pos, $idx, 1);
}   

say "input array    : @arr" ;
say "minimum sum    : $min_sum" ;
say "negative values:", sprintf " -%d" x @neg, @neg ;
say "\n", "equation:\n";
say join( ' + ', @pos) . (sprintf " - %d" x @neg, @neg) . " = $min_sum";