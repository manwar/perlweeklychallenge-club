#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       quads.pl
#
#       Special Quadruplets
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers.
# 
#         Write a script to find out the total special quadruplets for the
#         given array.
# 
#         Special Quadruplets are such that satisfies the following 2
#         rules.
#             1) nums[a] + nums[b] + nums[c] == nums[d]
#             2) a < b < c < d
# 
#         Example 1
#             Input:  @nums = (1,2,3,6)
#             Output: 1
# 
#             Since the only special quadruplets found is 
#             $nums[0] + $nums[1] + $nums[2] == $nums[3].
# 
#         Example 2
#             Input:  @nums = (1,1,1,3,5)
#             Output: 4
# 
#             $nums[0] + $nums[1] + $nums[2] == $nums[3]
#             $nums[0] + $nums[1] + $nums[3] == $nums[4]
#             $nums[0] + $nums[2] + $nums[3] == $nums[4]
#             $nums[1] + $nums[2] + $nums[3] == $nums[4]
# 
#         Example 3
#             Input:  @nums = (3,3,6,4,5)
#             Output: 0
# 
#         analysis
# 
#         Because the arrays are defined only to be integers, and not
#         ordered, a combination of index values that satisfy the
#         conditions may be present at any position. The only restriction
#         is applies is that the selected indexes must be ascending, so
#         that the first position cannot be greater than the index for the
#         end of the array minus 3: there must be space to complete the
#         selection.

#         Futhermore as we are beholden to chosing indexes in an ascending
#         sequence we are constrained from sdorting — mostly. Actually as
#         long as the three summands preced the final sum we can reassrange
#         them in any required order. So we could perhaps make a list of
#         sorted arrays, starting with the leftmost three items sorted, ten
#         four items, then five. As long as a single possible sum remains
#         it theory we could find a sucessful solution. Although any value
#         in the unsorted portion of a list could match the sum for a given
#         subsequence pattern we have an inverse tradeoff at work: fewer
#         sorted items yield fewer This is curious design pattern that
#         reminds me of dynamic programming. Not sure if it could be useful
#         in this case but it's really intereting. 
#
#         A series of nested loops would do the job, checking all
#         combinations. Algorithmically this is effective yet problematic,
#         but there is little to be done.
# 
#         The actual number of combinations is tricky to compute but
#         ultimately rises factorially. Even though our permissible
#         starting positions are reduced by 3 from the length of the array,
#         we still get 1 less possibility for the next position and one
#         more less for the next, and one more less for the sum to follow.
#         Given a long enough array we will still see factorial growth. the
#         actual rate is supressed at the start but this initial adjustment
#         will become less influential as the size increases.
# 
#         However some strategies can be employed to try and short-circuit
#         out of the search if possible and maybe we should try some to
#         make this more interesting.
# 
#         We could, for instance, scan the array once and get the maximum
#         value. Then, when summing a combination if two positiona already
#         sum to greater than the maximum we can stop that selection and
#         move on immediately. But wait. Neagative numbers are allowed.
#         Looks like were just stuck in the grind.
# 
#         Let's just implement a naive solution and see if anything comes
#         to mind later.
# 

#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';




my @arr = (1,1,1,3,5);

say count_quads( @arr );



sub count_quads( @arr ) {
    my ($i, $j, $k, $l);
    my $count = 0;
    
    for $i (0..$#arr-3) {
        for $j ($i+1..$#arr-2) {
            for $k ($j+1..$#arr-1) {
                for $l ($k+1..$#arr) {
                    $count++ if $arr[$i] + $arr[$j] + $arr[$k] == $arr[$l];
                }    
            }    
        }    
    }
    
    return $count;

}









use Test::More;

is count_quads(1,2,3,6),      1,      'ex-1';
is count_quads(1,1,1,3,5),    4,      'ex-2';
is count_quads(3,3,6,4,5),    0,      'ex-3';

done_testing();
