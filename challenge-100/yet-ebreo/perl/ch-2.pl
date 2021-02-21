use strict;
use warnings;
use feature qw(say);

# You are given triangle array.
# Write a script to find the minimum path sum from top to bottom.
# When you are on index i on the current row then you may move to either index i or index i + 1 on the next row.
# Example 1:
# Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
# Output: 8
# Explanation: The given triangle
#             1
#            2 4
#           6 4 9
#          5 1 7 2
# The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
#              [1]
#            [2]  4
#            6 [4] 9
#           5 [1] 7 2

my @triangle = ( [1], [2,4], [6,4,9], [5,1,7,2] );
my $min = 1e99;

sub f {
    my ($row, $col, $sum, $max) = @_;
    
    if ($row>$max) {
        ($sum < $min) && ($min = $sum); 
    } else {
        $sum += $triangle[$row][$col];

        f($row+1, $col,   $sum, $max);
        f($row+1, $col+1, $sum, $max);
    }
}

f(0, 0, 0, $#triangle);
say $min