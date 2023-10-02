#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       222-2-last-element-standing.pl
#
#       Last Member
# 
#         Submitted by: Mohammad S Anwar
#         You are given an array of positive integers, @ints.
# 
#         Write a script to find the last member if found otherwise return
#         0. Each turn pick 2 biggest members (x, y) then decide based on
#         the following conditions, continue this until you are left with 1
#         member or none.
# 
#             a) if x == y then remove both members
#     
#             b) if x != y then remove both members and add new member (y-x)
# 
# 
#       Example 1:
# 
#         Input: @ints = (2, 7, 4, 1, 8, 1)
#         Output: 1
# 
#         Step 1: pick 7 and 8, we remove both and add new member 1 => (2, 4, 1, 1, 1).
#         Step 2: pick 2 and 4, we remove both and add new member 2 => (2, 1, 1, 1).
#         Step 3: pick 2 and 1, we remove both and add new member 1 => (1, 1, 1).
#         Step 4: pick 1 and 1, we remove both => (1).
# 
#       Example 2:
# 
#         Input: @ints = (1)
#         Output: 1
# 
#       Example 3:
# 
#         Input: @ints = (1, 1)
#         Output: 0
# 
#         Step 1: pick 1 and 1, we remove both and we left with none.

#       Method:
# 
#         There is, as has often been noted, more than one way to do it.
#         This is good general advice in life, and Perl takes the
#         expression as it's credo. The algortithm as described could be
#         reduced to the steps of sorting, selecting, processing and
#         repeating, with a check at every pass as to whether we have less
#         than two elements to compare.
# 
#         That seems like it should work quite nicely. You do, however,
#         have to sort the array over and over as you insert the reduced
#         elements back in, which sounds kind of boring and inefficient. If
#         we were in a hurry we would refrain from the cardinal sin of
#         premature optimization, but in this sandbox we suffer no such
#         constraints. What if we could reinsert the difference at the
#         right place in the array when we compute it, obviating any need
#         to resort?
# 
#         The obvious tradeoff is sorting the whole array versus looking
#         for the correct insertion point for the new differential element.
#         But here's the thing: sorting the array, no matter the algorithm
#         we use to go about it, will always require us to handle every
#         element. However if we examine the array elements from smallest
#         upward, we can stop when the next element is larger and insert
#         there. Seems like that will shed some unnecessary effort.
# 
#         Let's do that. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use constant { VERBOSE => 1};

my @arr = @ARGV;
@arr == 0 and @arr = (1,1,1,15,7);
@arr = sort {$a<=>$b} @arr;
VERBOSE && say "@arr";

## let the games begin!
while (@arr > 1) {

    ## remove the last two elements and test their difference
    ## scan the remaining array and reinsert at the point
    ## where the next element is larger or the array ends
    my ($sec, $last) = splice @arr, -2;
    if (my $diff = $last - $sec) {
        my $c = 0;
#         $c++ while (exists $arr[$c] and $arr[$c] < $diff);
        ++$c while (@arr, $diff)[$c] < $diff;

        splice @arr, $c, 0, $diff;
        VERBOSE && say "@arr";
    }
}

say( @arr ? $arr[0]
          : 0        
);





