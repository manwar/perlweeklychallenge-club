=begin
You are given an m x n binary matrix with 0 and 1 only.

Write a script to find the largest square containing only 1's and return it’s area.

Example 1
Input: @matrix = ([1, 0, 1, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 0, 0, 1, 0])
Output: 4

Two maximal square found with same size marked as 'x':

[1, 0, 1, 0, 0]
[1, 0, x, x, 1]
[1, 1, x, x, 1]
[1, 0, 0, 1, 0]

[1, 0, 1, 0, 0]
[1, 0, 1, x, x]
[1, 1, 1, x, x]
[1, 0, 0, 1, 0]
=cut

use strict;
use warnings;

sub findMaxSquare {
    my @matrix = @{$_[0]};  # Input binary matrix
    my $m = scalar @matrix;
    my $n = scalar @{$matrix[0]};
    
    return 0 if $m == 0 || $n == 0;
    
    my @dp;
    my $max_side = 0;  # largest square 
    
    for my $i (0 .. $m - 1) {
        for my $j (0 .. $n - 1) {
            if ($matrix[$i][$j] == 1) {
                # Here we know it's just a 1x1 square
                if ($i == 0 || $j == 0) {
                    $dp[$i][$j] = 1;
                } else {
                    $dp[$i][$j] = 1 + min($dp[$i-1][$j], $dp[$i][$j-1], $dp[$i-1][$j-1]);
                }

                $max_side = $dp[$i][$j] if $dp[$i][$j] > $max_side;
            } else {
                $dp[$i][$j] = 0;
            }
        }
    }
    
    # Return the area of the largest square
    return $max_side * $max_side;
}

# Helper function to compute the minimum of three values
sub min {
    my ($a, $b, $c) = @_;
    return ($a <= $b && $a <= $c) ? $a : ($b <= $a && $b <= $c) ? $b : $c;
}


my @matrix= (
    [1, 0, 1, 0, 0],
    [1, 0, 1, 1, 1],
    [1, 1, 1, 1, 1],
    [1, 0, 0, 1, 0]
);

my $result = findMaxSquare(\@matrix);
print "The area of the largest square is: $result\n";

my @matrix1= (
    [0, 1],
    [1, 0]
);

my $result1 = findMaxSquare(\@matrix1);
print "The area of the largest square is: $result1\n";

my @matrix2= (
    [0]
);

my $result2 = findMaxSquare(\@matrix2);
print "The area of the largest square is: $result2\n";