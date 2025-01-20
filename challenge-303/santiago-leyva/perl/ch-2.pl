=begin
You are given an array of integers, @ints.

Write a script to return the maximum number of points you can earn by applying the following operation some number of times.

Pick any ints[i] and delete it to earn ints[i] points.
Afterwards, you must delete every element equal to ints[i] - 1
and every element equal to ints[i] + 1.
Example 1
Input: @ints = (3, 4, 2)
Output: 6

Delete 4 to earn 4 points, consequently, 3 is also deleted.
Finally delete 2 to earn 2 points.
Example 2
Input: @ints = (2, 2, 3, 3, 3, 4)
Output: 9

Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
Delete a 3 again to earn 3 points.
Delete a 3 once more to earn 3 points.  
=cut

use strict;
use warnings;

use strict;
use warnings;

sub deleteAndEarn {
    my ($nums) = @_;
    
    my $mx = -1;
    foreach my $num (@$nums) {
        $mx = $num if $num > $mx;
    }

    my %total;
    foreach my $num (@$nums) {
        $total{$num} += $num;
    }

    my $first = 0;
    my $second = 0;
    
    # Iterate through the numbers in ascending order (sorted keys of the hash)
    my @array = keys %total;
    foreach my $i (sort { $a <=> $b } @array) {
        # If the current number is adjacent to the previous one, we can't take both
        my $cur = $first + $total{$i} > $second ? $first + $total{$i} : $second;
        $first = $second;
        $second = $cur;
    }

    return $second;
}

# Example usage
my @nums = (3, 4, 2);
print deleteAndEarn(\@nums), "\n";  # Expected output: 6

my @nums2 = (2, 2, 3, 3, 3, 4);
print deleteAndEarn(\@nums2), "\n";  # Expected output: 9