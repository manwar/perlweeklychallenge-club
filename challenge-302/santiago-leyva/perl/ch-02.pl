=begin
You are given an array of integers, @ints.

Write a script to find the minimum positive start value such that step by step sum is never less than one.

Example 1
Input: @ints = (-3, 2, -3, 4, 2)
Output: 5

For start value 5.
5 + (-3) = 2
2 + (+2) = 4
4 + (-3) = 1
1 + (+4) = 5
5 + (+2) = 7
Example 2
Input: @ints = (1, 2)
Output: 1
Example 3
Input: @ints = (1, -2, -3)
Output: 5
=cut

use strict;
use warnings;
use List::Util qw(min);

my @nums = ([-3, 2, -3, 4, 2],[1, 2],[1, -2, -3]);

foreach(@nums){
    my @arr = @$_;
    my $result = findStart(\@arr);
    print "For ",join(" ",@arr)," the start value is -> $result \n";
}

sub findStart {
    my @A = @$_;

    my $s = 0;  # Initialize the cumulative sum
    my $t = 'inf';  # Initialize the minimum sum encountered
    
    for my $i (@A) {
        $s += $i;  # Update the cumulative sum
        #print "$s\n";
        $t = min($t, $s);  # Track the minimum cumulative sum
        print "$t\n";
    }
    
    return $t < 0 ? 1 - $t : 1;  # Return max(1, 1 - minimum cumulative sum)
}