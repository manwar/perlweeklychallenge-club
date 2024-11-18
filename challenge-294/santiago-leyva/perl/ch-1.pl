=begin
You are given an unsorted array of integers, @ints.

Write a script to return the length of the longest consecutive elements sequence. Return -1 if none found. The algorithm must runs in O(n) time.

Example 1
Input: @ints = (10, 4, 20, 1, 3, 2)
Output: 4

The longest consecutive sequence (1, 2, 3, 4).
The length of the sequence is 4.
Example 2
Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
Output: 9
Example 3
Input: @ints = (10, 30, 20)
Output: -1
=cut

use strict;
use warnings;
use List::Util qw(max);
use Data::Dumper;

my @tests = ([10, 4, 20, 1, 3, 2],[0, 6, 1, 8, 5, 2, 4, 3, 0, 7],[10, 30, 20]);

foreach(@tests){
    my @arr = @$_;
    my $longestCon = findLongConsecutive(\@arr);
    print "for ",join(" ",@arr)," -> $longestCon \n";
}

sub findLongConsecutive {
    my $input = shift;
    my @A = @$input;


    my %set = map { $_ => 1 } @A;  # O(n): creating a set of unique elements
    my $max = 0;

    # Iterate over the unique elements
    for my $num (@A) {
        # Only process numbers that are the start of a sequence
        if (!exists $set{$num - 1}) {
            my $current_num = $num;
            my $count = 1;
            # Count consecutive numbers starting from the current number
            while (exists $set{$current_num + 1}) {
                $current_num++;
                $count++;
            }
            $max = max($max, $count);
        }
    }

    $max = ($max > 1) ? $max : -1;
    return $max;

}