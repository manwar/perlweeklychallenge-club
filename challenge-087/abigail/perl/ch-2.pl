#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
# You are given matrix m x n with 0 and 1.
#
# Write a script to find the largest rectangle containing only 1.
# Print 0 if none found.
#

#
# Notes:
#   - Again, we have an example contradicting the challenge.
#     According to the example, the following matrix:
#
#              1 0 1 0 1 0
#              0 1 0 1 0 1
#              1 0 1 0 1 0
#              0 1 0 1 0 1
#
#     Should have an output of 0. But the matrix as 12 1x1 rectangles!
#
#     And I'm not sure what to think of this. Does it mean we need to
#     special case 1x1 rectangles? Any 1xn or nx1 rectangle? Perhaps any
#     rectangle which isn't a square? 
#
#     Bad exercise.
#
#     We opt to special case just 1x1 rectangles.
#
#
#   - The challenge also doesn't say what counts as the "largest"
#     rectangle. Largest area? Widest? Highest? Largest side?
#     Largest perimeter?
#
#     We pick largest area.
#

#
# A naive implementation would be a quartic algorithm. We can do better,
# using a cubic algorithm.
#
# First, we replace every 1 in the matrix with the number of from the
# current position to the first 0 below it. We can do this in a single
# pass, working bottom to top.
#
# Then, for each cell (x, y) in the matrix, we scan to the right (in the
# y direction), until we hit a zero (or the end of the row). For each 
# cell (x, y + k) in the scan, we keep track of the minimum value in
# points (x, y + m), 0 <= m <= k, as calculated in the step above.
# Let this value be p. Then the maximum sized rectangle we can make
# with the points (x, y) and (x, y + k) as (top) vertices of that
# rectangle is (k + 1) x p.
#

#
# Read in matrix
#
my @matrix = map {[/[01]/g]} <>;

#
# Sanity check
#
@$_ == @{$matrix [0]} || die "Not a matrix" for @matrix;

my $X =   @matrix;
my $Y = @{$matrix [0]};

#
# Fill the matrix with runs.
#
for (my $x = $X - 2; $x >= 0; $x --) {
    $matrix [$x] = [map {$matrix [$x]     [$_] *
                        ($matrix [$x + 1] [$_] + 1)} keys @{$matrix [$x]}];
}

my $best = [0, 0];

for (my $x = 0; $x < $X; $x ++) {
    for (my $y = 0; $y < $Y; $y ++) {
        next unless $matrix [$x] [$y];  # Top left is not a 1.
        #
        # Now, scan to the left, keeping track of the *minimum* value $r
        # in @runs. If 0, we can stop scanning. While scanning track
        # how far we're from $y, and calculate the rectangle covered.
        #
        my $min_depth = $matrix [$x] [$y];
        $best = [$min_depth, 1] if $min_depth > $$best [0] * $$best [1];
        for (my $w = 1; $y + $w < $Y && $min_depth; $w ++) {
            $min_depth = $matrix [$x] [$y + $w] if
                         $matrix [$x] [$y + $w] < $min_depth;
            $best = [$min_depth,   $w + 1] if
                     $min_depth * ($w + 1) > $$best [0] * $$best [1];
        }
    }
}

#
# Print 0 if the matrix does not contain a single 1 (no rectangles),
# of only 1x1 rectangles (as per contradicting example).
#
if ($$best [0] * $$best [1] <= 1) {
    say 0;
}
else {
    say join " ", (1) x $$best [1] for 1 .. $$best [0];
}


__END__
