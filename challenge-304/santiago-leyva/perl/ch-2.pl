=begin
You are given an array of integers, @ints and an integer, $n which is less than or equal to total elements in the given array.

Write a script to find the contiguous subarray whose length is the given integer, $n, and has the maximum average. It should return the average.

Example 1
Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
Output: 12.75

Subarray: (12, -5, -6, 50)
Average: (12 - 5 - 6 + 50) / 4 = 12.75
Example 2
Input: @ints = (5), $n = 1
Output: 5
=cut

use strict;

my @nums = ([1, 12, -5, -6, 50, 3],[5]);
my @x = ([4],[5]);

foreach(0 ..scalar @nums -1){
    my @arr = @{$nums[$_]};
    my $number = $x[$_][0];
    my $result = findAverage(\@arr,$number);
    print "$result \n";
}

sub findAverage {
    
    my ($nums, $k) = @_;

    # Calculate the sum of the first 'k' elements
    my $s = 0;
    $s += $_ for @$nums[0..$k-1];
    my $ans = $s;

    # Use sliding window
    for my $i ($k..@$nums-1) {
        $s += $nums->[$i] - $nums->[$i - $k];
        $ans = $s if $s > $ans;
    }

    return $ans / $k;
}