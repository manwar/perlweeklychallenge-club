#!/usr/bin/perl

use v5.16;
use warnings;
use SVG;
use PDL;
use experimental qw(signatures postderef);
# mirror:
use constant MI => pdl(1, -1);
# origin:
use constant ORIG => pdl(10, 10);
# point radius:
use constant R => 3;

# Do nothing but define subs to be imported into another program if
# $norun is set.  See task 2.
our $norun;
goto end if $norun;

die <<EOS if @ARGV && $ARGV[0] eq -h;
usage: $0 [FILE]

FILE
    Name of a file holding point and line coordinates.  Prints the
    generated SVG to STDOUT.

    Call $0 ch-1.in to produce the example SVG or
    perl -pe 's/\\s+/\\n/gm ch-2.in | $0
    to visualize the second task's input data.

EOS


### Input and Output

say gen_svg(read_data(\*ARGV));


### Implementation

# Reading data from file handle and build piddles holding point and line
# endpoint coordinates respectively.
sub read_data($fh) {
    # Collect points in a 2xN piddle. Can glue to a null piddle.
    my $points = null;
    # Collect lines in a 2x2xM piddle.  An initial structure with
    # dimensions 2x2x0 is needed to be able to flatten to 2x0
    # afterwards if there a no lines.
    my $lines = pdl(null, null)->xchg(0, 1)->dummy(0, 2);

    # Read input lines of two or four coordinates representing a point
    # or a line respectively and add these to the proper piddle.
    while (<$fh>) {
        my ($x1, $y1, $x2, $y2) = split /, */;
        if (defined $y2) {
            # Build a 2x2x1 piddle from the line's endpoints and augment the
            # existing line list
            $lines = $lines->glue(2, pdl([$x1, $y1], [$x2, $y2])->dummy(2));
        } else {
            # Build a 2x1 piddle from the point and augment the existing
            # point list.
            $points = $points->glue(1, pdl($x1, $y1)->dummy(1));
        }
    }
    
    ($points, $lines);
}

# Generate an SVG from given points and lines.  SVGs have a special
# coordinate system: The origin is located at the upper left corner, the
# x axis goes rightwards and the y axis goes downwards - in contrast to
# the usually expected behaviour.  Mirroring y values to regain the
# expected outcome with a transformation (x, y) -> (x - minX, maxY - y).
sub gen_svg ($points, $lines) {
    # Build a piddle from all points and line endpoints.  For that
    # purpose the lines piddle is flattened from 2x2xM to 2x2M,
    # compatible with the 2xN points piddle.  The result (after
    # transpose) is a (N+2M)x2 piddle.
    my $allpoints = $points->glue(1, $lines->clump(1, 2))->xchg(0, 1);
    # Build $minmax as a 2x2 piddle holding the negative minimum and the
    # maximum x and y coordinates from all points.  This special piddle
    # comes handy, as the sum over the x and y values respectively
    # produces the size of a surrounding rectangle and the diagonal
    # gives the shift in the aforementioned transformation.
    my $minmax = -(MI->dummy(0)) * pdl(($allpoints->minmaximum)[0, 1]);
    my $shift = $minmax->diagonal(0, 1);

    # Build an SVG object in the required size plus borders.
    (\my %attr)->@{qw(width height)} =
        ($minmax->xchg(0, 1)->sumover + 2 * ORIG)->list;
    my $svg = SVG->new(%attr);

    # Create a group providing common circle attributes.
    my $cg = $svg->group(id => 'cg', fill => '#f73');
    # Transform the points' coordinates into SVG coordinates with origin
    # ORIG and create (small) circles around these.
    (ORIG + $points * MI + $shift)->svg_circle($cg, R)
        unless $points->isempty;

    # Create a group providing common line attributes.
    my $lg = $svg->group(id => 'lg', 'stroke-width' => 4, stroke => '#369');
    # Transform the lines' endpoint coordinates into SVG coordinates with
    # origin ORIG and create lines connecting these.  The lines'
    # endpoint pairs need to be flattened from 2x2 to 4x1.
    (ORIG + $lines * MI + $shift)->clump(0, 1)->svg_line($lg)
        unless $lines->isempty;

    # Return the SVG object as XML.
    $svg->xmlify;
}

# Let the fun begin:
# Defining two PDL methods 'svg_circle' and 'svg_line' that are
# threading over a piddle's first dimension to create SVG circles and
# lines respectively.

BEGIN {
    # Threaded creation of SVG circles:
    # Create a circle of radius $r around the given point.
    # Method args: svg, radius
    thread_define 'PDL::svg_circle(a(2)), NOtherPars => 2', over {
        my ($point, $svg, $r) = @_;
        (\my %attr)->@{qw(cx cy r)} = ($point->list, $r);
        $svg->circle(%attr);
    };

    # Threaded creation of SVG lines:
    # Create a line connecting its endpoint coordinates.
    # Method arg: svg
    thread_define 'PDL::svg_line(a(4)), NOtherPars => 1', over {
        my ($line, $svg) = @_;
        (\my %attr)->@{qw(x1 y1 x2 y2)} = $line->list;
        $svg->line(%attr);
    };
}

end:
1;
