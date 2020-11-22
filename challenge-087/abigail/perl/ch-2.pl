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
# A naive implementation would be a for each pair of points see whether
# there's a rectangle with 1s, with the pair of points opposite vertices
# of the array.
#
# If done correctly, that leads to an Omega (l^2 * m^2) algorithm,
# if the size of the input is an l x m matrix. So, Omega (N^2)
# where N = l * m.
#
# But we can do better. We can use an algorithm which runs in
# O (l * m * min (l, m)) time, or O (N sqrt (N)) time, since
# min (l, m) <= sqrt (N).
#
# Assume the matrix is not wider than it is high (otherwise, first
# transpose the matrix -- which can be done in O (l * m) time).
#
# First, we replace every 1 in the matrix with how many 1's (including
# the 1 in the current position) it takes the hit the first 0 below it.
# We can do this in a single pass, working bottom to top.
#
# So, the matrix 
#
#          0 1 0 1 1
#          0 1 0 1 1
#          0 1 1 1 1
#          1 0 0 1 1
#          0 0 0 1 1
#          0 0 1 0 0
#
# becomes
#
#          0 3 0 5 5
#          0 2 0 4 4
#          0 1 1 3 3
#          1 0 0 2 2
#          0 0 0 1 1
#          0 0 1 0 0
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
# Transpose if necessary
#
my $transpose;
if ($X < $Y) {
    my @matrix_t;
    for (my $x = 0; $x < $X; $x ++) {
        for (my $y = 0; $y < $Y; $y ++) {
            $matrix_t [$y] [$x] = $matrix [$x] [$y];
        }
    }
    @matrix = @matrix_t;
   ($X, $Y) = ($Y, $X);
    $transpose = 1;
}

#
# Fill the matrix with runs.
#
for (my $x = $X - 2; $x >= 0; $x --) {
    $matrix [$x] = [map {$matrix [$x]     [$_] *
                        ($matrix [$x + 1] [$_] + 1)} keys @{$matrix [$x]}];
}


#
# Find the largest rectangle.
#
my $best = [0, 0];
for (my $x = 0; $x < $X; $x ++) {
    for (my $y = 0; $y < $Y; $y ++) {
        next unless $matrix [$x] [$y];  # Top left is not a 1.
        #
        # Now, scan to the right, keeping track of the *minimum* value $r
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
    $best = [$$best [1], $$best [0]] if $transpose;
    say join " ", (1) x $$best [1] for 1 .. $$best [0];
}


__END__
