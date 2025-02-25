=begin
You are given an array of binary strings, @str, and two integers, $x and $y.

Write a script to return the size of the largest subset of @str such that there are at most $x 0’s and $y 1’s in the subset.

A set m is a subset of n if all elements of m are also elements of n.
Example 1
Input: @str = ("10", "0001", "111001", "1", "0")
       $x = 5
       $y = 3
Output: 4

The largest subset with at most five 0's and three 1's:
("10", "0001", "1", "0")
Example 2
Input: @str = ("10", "1", "0")
       $x = 1
       $y = 1
Output: 2

The largest subset with at most one 0's and one 1's:
("1", "0")
=cut

use strict;
use warnings;

sub findMaxForm {
    my ($strs, $m, $n) = @_;
    
    # Get the size of the strs array
    my $sz = scalar @$strs;
    
    # Initialize the DP table with 3D array
    my @f;
    for my $i (0..$sz) {
        for my $j (0..$m) {
            for my $k (0..$n) {
                $f[$i][$j][$k] = 0;
            }
        }
    }

    # Loop over all strings
    for my $i (1..$sz) {
        my $s = $strs->[$i - 1];  # Get the i-th string (1-indexed in loop)
        my $a = ($s =~ tr/0//);  # Count of '0's
        my $b = ($s =~ tr/1//);  # Count of '1's

        # Update the DP table
        for my $j (0..$m) {
            for my $k (0..$n) {
                $f[$i][$j][$k] = $f[$i - 1][$j][$k];  # Not including the current string
                if ($j >= $a && $k >= $b) {
                    # Include the current string if we have enough 0's and 1's
                    $f[$i][$j][$k] = max($f[$i][$j][$k], $f[$i - 1][$j - $a][$k - $b] + 1);
                }
            }
        }
    }

    return $f[$sz][$m][$n];  # Return the result stored in the bottom-right corner of the DP table
}

# Helper function to get the maximum of two values
sub max {
    my ($a, $b) = @_;
    return $a > $b ? $a : $b;
}

# Example usage
my @str1 = ("10", "0001", "111001", "1", "0");
my $m1 = 5;
my $n1 = 3;
print findMaxForm(\@str1, $m1, $n1), "\n";  # Expected Output: 4

my @str2 = ("10", "1", "0");
my $m2 = 1;
my $n2 = 1;
print findMaxForm(\@str2, $m2, $n2), "\n";  # Expected Output: 2