#!/usr/bin/perl -s

use v5.16;
use PDL;
use List::Util 'pairs';
use Test2::V0 '!float';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 6;
usage: $0 [-examples] [-tests] [-verbose] [--] [x1 y1 x2 y2 x3 y3]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

x1 ... y3
    coordinates of the triangle's corners

EOS


### Input and Output

say inner_origin(pairs @ARGV);


### Implementation

# Check if the origin [0, 0] is inside a given triangle or on its
# border.  The triangle is specified by the coordinates of its corners
# and may be degenerated: The corners may be located on a common line
# and need not be distinct.
# Two consecutive checks are performed:
# 1) Origin orientation:
#    The coordinates of each pair of the triangle's corners form a 2x2
#    matrix.  The sign of the corresponding determinant signals if the
#    origin is left or right of the directed edge connecting these
#    points.  If the origin is an inner point, all three orientations
#    must agree, whereas an outer point will show different signs.
# 2) Axis projection:
#    If the three given points are collinear, all determinants are zero
#    and cannot be used as an indicator for "inner" and "outer".  In
#    that case the projection of the points onto the x and y axes reveal
#    the location of the origin inside or outside of the line segment.
sub inner_origin {
    # Convert coordinate pairs to a 3x2 piddle.
    my $p = pdl(@_)->xchg(0,1)->sever;
    say "coords:$p" if $verbose;

    # Get the minimum and the maximum of the three matrices'
    # determinants formed by the point pairs.
    my ($min_d, $max_d) = $p->range([[0, 0], [1, 0], [2, 0]], 2, 'p')
        ->reorder(1, 2, 0)->determinant->minmax;
    say "min/max det: $min_d/$max_d" if $verbose;

    # If determinants have different signs, the origin is outside the
    # triangle.
    return 0 if $min_d < 0 && $max_d > 0;

    # If there is at least one nonzero determinant and there are no
    # differing signs, the origin is located inside the triangle (or on
    # its border).
    return 1 if $min_d >= 0 && $max_d > 0 || $min_d < 0 && $max_d <= 0;

    # At this point all determinants are zero.

    # Get the projections onto the x and y axis for collinear points
    # and check if they both contain the origin.
    my ($min_p, $max_p) = $p->minmaximum;
    say "min/max proj: $min_p/$max_p" if $verbose;

    return 1 if max($min_p) <= 0 && min($max_p) >= 0;

    # Else: origin is not within the given line segment.
    0;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is inner_origin([0, 1], [1, 0], [2, 2]), F(), 'example 1';
        is inner_origin([1, 1], [-1, 1], [0,-3]), T(), 'example 2';
        is inner_origin([0, 1], [2, 0], [-6, 0]), T(), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is inner_origin([-1, -1], [-1, 2], [2, -1]), T(), 'inside';
        is inner_origin([2, -1], [2, 2], [-1, 2]), F(), 'outside';
        is inner_origin([0, 0], [3, 1], [1, 2]), T(), 'origin at corner';
        is inner_origin([1, 1], [3, 3], [-1, -2]), F(), 'two collinear points';
        is inner_origin([-1, -2], [0, -1], [1, 0]), F(), 'flat';
        is inner_origin([-1, -2], [1, 0], [1, 0]), F(), 'two points';
        is inner_origin([-1, -1], [1, 1], [2, 2]), T(), 'aligned around origin';
        is inner_origin([-1, 1], [-2, 2], [-4, 4]), F(),
            'aligned without origin';
        is inner_origin([0, 0], [0, 0], [1, 1]), T(), 'two points at origin';
        is inner_origin([0, 0], [0, 0], [0, 0]), T(), 'single point at origin';
        is inner_origin([1, 2], [1, 2], [1, 2]), F(), 'single point off origin';
	}

    done_testing;
    exit;
}
