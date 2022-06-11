#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       equal.pl
#
#       Equilibrium Index
#         Submitted by: Mohammad S Anwar
#         You are give an array of integers, @n.
# 
#         Write a script to find out the Equilibrium Index of the given
#         array, if found.
# 
#         For an array A consisting n elements, index i is an equilibrium
#         index if the sum of elements of subarray A[0…i-1] is equal to the
#         sum of elements of subarray A[i+1…n-1].
# 
# 
#         Example 1:
#             Input: @n = (1, 3, 5, 7, 9)
#             Output: 3
# 
#         Example 2:
#             Input: @n = (1, 2, 3, 4, 5)
#             Output: -1 as no Equilibrium Index found.
# 
#         Example 3:
#             Input: @n = (2, 4, 2)
#             Output: 1

#         method:
# 
#             The word "equilibrium" to me means a dynamic system where
#             multiple forces affect the state to alter it in one
#             directiion or another, yet taken together work to cancel each
#             other out, achieving a balanced stasis.
# 
#             This suggests in turn a dynamic algorithm, homing in on a
#             result, oscillating within a narrowing field until a final
#             central compromise is achieved.
# 
#             That would be one way to do it. On the other hand we could
#             also process the data list-wise in a single expression:
#             working left to right across the indices we sum the two
#             non-inclusive lists of elements on the left and right and
#             compare the two values, noting the first index where the
#             halves are equal.
# 
#             That would be a more direct way.
# 
#             Are there others? Sure. Let's look to an equilibrium solution
#             and see what it tells us.
# 
#             In an equilibrium state, as defined, the two sub-lists to
#             either side of a pivot point sum to the same value. Which
#             means the sum of the entire list is equal to 2 x the sum of
#             the equal outside list plus the pivot value. Well, we could
#             first sum the list, then walk it, keeping a running total of
#             all those elements seen previously to the element being
#             examined. Then this sum is doubled, the element value added,
#             and compared to the total sum. If they match we have found
#             the equilibrium index.
# 
#             This is a good plan, as we aren't continuously re-summing the
#             varying side-lists for every index. However it still does
#             require two traversals. Can we do it in one?
# 
#             One solution would be to walk the list, and at each element
#             compute the total of twice the sum of the previously seen
#             left-hand list and the value of the element, then store this
#             number in a hash pointing to the value of the index that
#             created it. Then, by the time we get to the end of the first
#             pass we will have all the information required to compute the
#             total sum. We then look up the has key with that value an it
#             will point to the equilibrium index.
# 
#             Clever, you might say, and I'd modestly answer yes I thought
#             so. But what if the keys weren't unique? Can a list have
#             *two* equilibrium points? If we only allow for positive
#             values can't, but if we admit negative vales and zeros to the
#             party — which aren't explicitly excluded in the description
#             — then we can construct multi-stable lists. The list
# 
#             (5, -5, 0, 5, 0)
# 
#             for instance has equlibria at inidices [1] and [3]. The list
# 
#             (5, -5, 0, 5, 0, -5, 5)
# 
#             similarly has stable centers at [1], [3], and [5]. The 0s can
#             be replaced with any sub-list that itself sums to 0.
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use List::Util qw( first sum );

sub eq_direct {
## exhaustive traversal, re-summing side-lists
    return (first { sum(@_[0..$_-1]) == sum(@_[$_+1..$#_]) } (1..$#_-1)) // -1;
} ;

sub eq_linear (@list) {
## single-pass continuous summing with lookup
    my %sums;
    my $total = $list[0];
    for (1..$#list-1) {
        $sums{ 2 * $total + $list[$_] } = $_;
        $total += $list[$_];
    }
    $total += $list[-1];
    return $sums{$total} // -1
}


use Test::More;

is eq_direct(1, 3, 5, 7, 9)   , 3,    'ex-1';
is eq_direct(1, 2, 3, 4, 5)   , -1,   'ex-2';
is eq_direct(2, 4, 2)         , 1,    'ex-3';


is eq_linear(1, 3, 5, 7, 9)   , 3,    'ex-1-lin';
is eq_linear(1, 2, 3, 4, 5)   , -1,   'ex-2-lin';
is eq_linear(2, 4, 2)         , 1,    'ex-3-lin';

## multi-stable arrays
is eq_direct(5, -5, 0, 5, 0)         , 1,    'bistable  exhaustive';
is eq_direct(5, -5, 0, 5, 0, -5, 5)  , 1,    'tristable exhaustive';

is eq_linear(5, -5, 0, 5, 0)         , 3,    'bistable  single pass';
is eq_linear(5, -5, 0, 5, 0, -5, 5)  , 5,    'tristable single pass';

done_testing();













# use Test::More;
# 
# is 
# 
# done_testing();
