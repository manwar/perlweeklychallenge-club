#!/usr/bin/perl -s

use v5.16;
use warnings;
use PDL;
use PDL::Slatec;
use experimental 'signatures';

our ($norun, $svg, $help);

die <<EOS if $help;
usage: $0 [-help] [-svg] [FILE]

-help
    Print this help.

-svg
    Print an SVG containing the points and the regression line on STDOUT.

FILE
    Name of a file holding (x, y) pairs.  The values of a single pair
    shall be separated by comma and pairs by whitespace.

    Call "./ch-2.pl ch-2.in" to solve task 2. (Output: regression line
    endpoints.)

    Call "./ch-2.sh -svg ch-2.in" to solve task 2 and generate an SVG
    for visualization using the solution to task 1.

EOS


### Input and Output

if ($svg) {
    # Import the SVG generator from task 1.
    local $norun = 1;
    do "./ch-1.pl" or die $@;
    say scalar least_square_linear_regression(\*ARGV);
} else {
    say join ", ", least_square_linear_regression(\*ARGV);
}


### Implementation

sub least_square_linear_regression ($fh) {
    # Slurp the file content, remove trailing whitespace, convert
    # whitespace to semicolons and use the resulting string as a piddle
    # constructor argument.  This results in a 2xN piddle of coordinate
    # pairs.
    my $points = do {
        local $/;
        pdl <$fh> =~ s/\s+\z//r =~ s/\s+/;/gr
    };
    # Split the points' coordinates in separate piddles along the first
    # dimension resulting in piddles for x and y values as required by
    # "polyfit".  Then find the best fit with a polynomial of degree one
    # (i.e. a line).  Here only the solution's internal representation
    # is needed as the result.
    my $fit = (polyfit $points->xchg(0, 1)->dog, ones($points->dim(1)), 1)[3];
    # Get the x range.
    my $x = pdl minmax $points->slice(0);
    # Get the corresponding y values.
    my $y = (polyvalue(1, 0, $x, $fit))[0];
    # Create a line piddle having x and y as endpoint coordinates.
    my $line = pdl($x, $y)->xchg(0, 1);

    if (wantarray) {
        # Flatten the line piddle.
        return $line->list;
    } else {
        # Convert the line endpoints (2x2) into the shape expected by
        # gen_svg (2x2x1) from task 1 and generate an SVG from the given
        # points and the regression line.
        return gen_svg($points, $line->dummy(2));
    }
}
