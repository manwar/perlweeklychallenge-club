=begin
You are given an array of integers, @ints.

Write a script to find out the next permutation of the given array.

The next permutation of an array of integers is the next lexicographically greater permutation of its integer.

Example 1
Input: @ints = (1, 2, 3)
Output: (1, 3, 2)

Permutations of (1, 2, 3) arranged lexicographically:
(1, 2, 3)
(1, 3, 2)
(2, 1, 3)
(2, 3, 1)
(3, 1, 2)
(3, 2, 1)
Example 2
Input: @ints = (2, 1, 3)
Output: (2, 3, 1)
Example 3
Input: @ints = (3, 1, 2)
Output: (3, 2, 1)
=cut

use strict;
use Data::Dumper;

my @input = ([1, 2, 3],[2, 1, 3],[3, 1, 2]);

foreach(@input){
    my @arr = @$_;
    my @next_perm = findNextPerm(\@arr);
    print "( ".join(" ",@arr)." ) -> ( ".join(" ",@next_perm)," ) \n";
}

sub findNextPerm {
    my @ints = @$_;

    # Step 1: Find the largest index k such that ints[k] < ints[k + 1]
    my $k = $#ints - 1;
    $k-- while $k >= 0 && $ints[$k] >= $ints[$k + 1];
    
    if ($k >= 0) {
        # Step 2: Find the largest index l such that ints[k] < ints[l]
        my $l = $#ints;
        $l-- while $ints[$k] >= $ints[$l];
        
        # Step 3: Swap ints[k] and ints[l]
        @ints[$k, $l] = @ints[$l, $k];
    }
    
    # Step 4: Reverse the sequence from k+1 to end
    my $start = $k + 1;
    my $end = $#ints;
    while ($start < $end) {
        @ints[$start, $end] = @ints[$end, $start];
        $start++;
        $end--;
    }
    return @ints;
}