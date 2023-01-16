#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       not-a-bad-couple.pl

#         ... but there's always room for one more.
# 
#       Good Pairs
#         Submitted by: Mohammad S Anwar
#         You are given a list of integers, @list.
# 
#         Write a script to find the total count of Good Pairs.
# 
# 
#         A pair (i, j) is called good if list[i] == list[j] and i < j.
# 
# 
#         Example 1
#             Input: @list = (1,2,3,1,1,3)
#             Output: 4
# 
#             There are 4 good pairs found as below:
#                 (0,3)
#                 (0,4)
#                 (3,4)
#                 (2,5)
# 
#         Example 2
#             Input: @list = (1,2,3)
#             Output: 0
# 
#         Example 3
#             Input: @list = (1,1,1,1)
#             Output: 6
# 
#             Good pairs are below:
#                 (0,1)
#                 (0,2)
#                 (0,3)
#                 (1,2)
#                 (1,3)
#                 (2,3)
#
#         analysis:
# 
#         The "pairs" in question here are pairs of equal values, expressed
#         as their indices. The definition specifies that the first index
#         be smaller than the second.
# 
#         What this means is that every pair of equal values found in the
#         input array can be ordered numerically by their indices and the
#         result will constitute a "good pair". Further, the complement
#         ordering, with the indices swapped, will always fail the
#         condition so that each pairing will only be counted once.
# 
#         The examples show the actual good pairs found, however we are
#         only asked for the number of such pairings. This can be solves
#         mathematically if we iterate through each element in the arrays
#         and for each then iterate through each succeeding element to see
#         if it matches the value. Every time we find a match we increment
#         a counter. Easy peasy.
# 
#         This looks at each element once in an outer loop, and in an inner
#         loop a sublist based on the initial index, shrinking as we
#         proceed. This all will happen in O(n log n) time complexity.
# 
#         On the other hand we can look at the problem combinatorially. If
#         we have, say four 1s present in the list, then each 1 can be
#         paired with each other 1 in another position. This results in n x
#         (n-1) combination pairings. But, as we have seen, each pairing
#         will group two indices in one of two orderings, of which only one
#         ordering will constitute a "good pair". Thus we divide the total
#         groupings by 2 to find the number of good pairs.
# 
#         Count = (n)(n-1)/2

#         For this we need to traverse the list once to assemble a
#         frequency hash of the values within it, then for each value add
#         the count for each value found to a total sum. The result is the
#         final count of good pairs.
# 
#         As we only traverse the list once, and then following in a
#         separate action traverse the list of values assembled, the number
#         of calculations performed is maximally twice the length of the
#         original list, which happens with a list of unique values.
#         However in any case the time complexity is still O(n).
        
        
        
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



my @list =  @ARGV;
   @list == 0 and @list = (1,1,1,1);

my (%freq, $count);

$freq{$_}++             for @list;          ## create freq hash
$count += ($_*($_-1))/2 for values %freq;   ## sum calculations for each hash value

say $count;

