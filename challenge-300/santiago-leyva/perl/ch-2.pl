=begin
You are given an array of integers, @ints of length n containing permutation of the numbers in the range [0, n - 1].

Write a script to build a set, set[i] = ints[i], ints[ints[i]], ints[ints[ints[i]]], ..., subjected to the following rules:

1. The first element in set[i] starts with the selection of elements ints[i].
2. The next element in set[i] should be ints[ints[i]], and then ints[ints[ints[i]]], and so on.
3. We stop adding right before a duplicate element occurs in set[i].
Return the longest length of a set set[i].

Example 1
Input: @ints = (5, 4, 0, 3, 1, 6, 2)
Output: 4

ints[0] = 5
ints[1] = 4
ints[2] = 0
ints[3] = 3
ints[4] = 1
ints[5] = 6
ints[6] = 2

One of the longest sets set[k]:
set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}
Example 2
Input: @ints = (0, 1, 2)
Output: 1
=cut

use strict;
use warnings;

my @examples = ([5, 4, 0, 3, 1, 6, 2],[0, 1, 2]);

foreach(@examples){
    my @arr = @$_;
    my $result = longest_set_length(@arr);
    print "$result \n";
}

sub longest_set_length {
    my (@ints) = @_;
    my $n = scalar @ints;
    my @visited = (0) x $n;  # Array to track visited elements
    my $max_length = 0;  # To store the longest set length
    
    for my $i (0 .. $n - 1) {
        next if $visited[$i];  
        

        my %seen;  # Hash to track elements in the current set
        my $current = $i;
        my $length = 0;
        
        while (!$seen{$current}) {
            $seen{$current} = 1;  # Mark current element as seen in this set
            $visited[$current] = 1;  # Mark the element as visited globally
            $current = $ints[$current];  # Move to the next element
            $length++;  # Increase length of the current set
        }
        
        # Update the maximum length
        $max_length = $length if $length > $max_length;
    }
    
    return $max_length;
}
