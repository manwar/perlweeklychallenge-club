# Write a script to find the intersection of two straight lines. The
# co-ordinates of the two lines should be provided as command line parameter.
# For example:
#
#   The two ends of Line 1 are represented as co-ordinates (a,b) and (c,d).
#   The two ends of Line 2 are represented as co-ordinates (p,q) and (r,s).
#
# The script should print the co-ordinates of point of intersection of the
# above two lines.

# Computational geometry is always difficult, because there are so many border
# cases you have to take into account. I hope I covered all of them.
sub line_intersection(($x1, $y1), ($x2, $y2), ($x3, $y3), ($x4, $y4)) {
    if (($x1 == $x2 and $y1 == $y2) or ($x3 == $x4 and $y3 == $y4)) {
        die "Input doesn't represent two lines.";
    }
    my $disc = ($x1 - $x2) * ($y3 - $y4) - ($y1 - $y2) * ($x3 - $x4);
    if ($disc == 0) {
        if ($x1 == $x2 and $x2 == $x3 and $x3 == $x4) {
            # Lines coincide vertically. Return one coinciding point.
            return ($x1, $y1);
        }
        if ($y1 == $y2 and $y2 == $y3 and $y3 == $y4) {
            # Lines coincide horizontally. Return one coinciding point.
            return ($x1, $y1);
        }
        if (($y1 - $x1) * ($x4 - $x2) == ($y2 - $x2) * ($x3 - $x1)) {
            # Lines coincide diagonally. Return one coinciding point.
            return ($x1, $y1);
        }
        # If the discriminant is zero, the two lines are parallel to each
        # other. Therefore, depending on your definitions the lines don't
        # intersect, or they intersect at infinity, introducing a
        # non-Euclidian geometry. I choose the latter.
        return Inf;
    }
    # Discriminant is non-zero, hence there is one intersecting point.
    return ((($x1 * $y2 - $y1 * $x2) * ($x3 - $x4)
            - ($x3 * $y4 - $y3 * $x4) * ($x1 - $x2)) / $disc,
        (($x1 * $y2 - $y1 * $x2) * ($y3 - $y4)
            - ($x3 * $y4 - $y3 * $x4) * ($y1 - $y2)) / $disc);
}

line_intersection((-1, -1), (1, 1), (1, -1), (-1, 1)).say;
line_intersection((0, 0), (1, 1), (1, 0), (2, 1)).say;
line_intersection((0, 0), (1, 1), (2, 2), (3, 3)).say;
try {
    line_intersection((1, 1), (1, 1), (2, 2), (3, 3)).say;
}
if $! {
    say "Expected error, because the input doesn't represent a line.";
}
