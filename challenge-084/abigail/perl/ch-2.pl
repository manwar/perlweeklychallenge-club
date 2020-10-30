#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# You are given matrix of size m x n with only 1 and 0.
#
# Write a script to find the count of squares having all four corners set as 1.
#

#
# Notes:
#  - Judging from the examples, we're not counting 1x1 squares.
#  - All the given examples are 4x4 squares. 
#     o So we need some extra test cases.
#

#
# Initialize the matrix
#
my $matrix = [map {[/[01]/g]} <>];

#
# Get the sizes. We're assuming the input is sane, that is,
# we have proper matrices.
#
my $X =   @$matrix;
my $Y = @{$$matrix [0]};

#
# Trivial cubic algorithm. Loop over the x, y and for all k such that
# x < x + k < $X and y < y + k < $Y, check whether [x, y], [x + k, y],
# [x, y + k], [x + k, y + k] are all 1.
#
my $count = 0;
for (my $x = 0; $x < $X; $x ++) {
    for (my $y = 0; $y < $Y; $y ++) {
        next unless $$matrix [$x] [$y]; # No need to iterate over k
                                        # if the first corner is 0.
        for (my $k = 1; $x + $k < $X && $y + $k < $Y; $k ++) {
            $count ++ if $$matrix [$x + $k] [$y]      &&
                         $$matrix [$x]      [$y + $k] &&
                         $$matrix [$x + $k] [$y + $k];
        }
    }
}

say $count;

__END__
