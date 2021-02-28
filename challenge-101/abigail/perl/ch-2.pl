#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# See https://stackoverflow.com/questions/2049582/
#

#
# This determines on which side of the line through ($x1, $y1) and
# ($x2, $y2) the origin lies. If > 0, then the origin lies to the left
# of the line, if < 0, the origin lies to the right of the line, if
# = 0, the origin lies on the line.
#
sub side ($x1, $y1, $x2, $y2) {
    ($y2 - $y1) * $x2 - ($x2 - $x1) * $y2;
}

while (<>) {
    my ($x1, $y1, $x2, $y2, $x3, $y3) = split;

    #
    # Determine where the origin is relative to the three lines 
    # through the vertices of the triangle. Note we have to go
    # in a specific order through the points. (Either clock wise,
    # or counter clockwise, as long as we're consistent).
    #
    my $s1 = side ($x2, $y2, $x3, $y3);
    my $s2 = side ($x3, $y3, $x1, $y1);
    my $s3 = side ($x1, $y1, $x2, $y2);

    #
    # If the origin either lies to the left (or on) each of the
    # lines, or to the right (or on) each of the lines, the origin
    # lies inside the triangle. If not, it does not.
    #
    say $s1 <= 0 && $s2 <= 0 && $s3 <= 0 ||
        $s1 >= 0 && $s2 >= 0 && $s3 >= 0 ? 1 : 0
}
