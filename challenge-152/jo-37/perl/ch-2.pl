#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::AllUtils qw(reduce pairmap any);
use Syntax::Keyword::Gather;
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [BL1x,BL1y TR1x,TR1y BL2x,BL2y TR2x,TR2y ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

BL1x,BL1y TR1x,TR1y BL2x,BL2y TR2x,TR2y ...
    coordinates of the bottom left and top right vertices of some rectangles

EOS


### Input and Output

say rectangle_area(map [split /[, ] */], @ARGV);


### Implementation

# Generalizing the task to N rectangles.
# These rectangles, given by their bottom left and upper right vertices,
# are contained within a unique minimal rectangle. This outer rectangle
# may be divided into (N + 1)² (possibly empty) subrectangles given by
# all possible x and y coordinates from the original rectangles.  Each
# of these subrectangles has a clear relation to any of the original
# rectangles: either they are disjoint or the subrectangle is a subset
# of the original.  In other words: the characteristic function of any
# given rectangle never changes inside such subrectangle. For each
# subrectangle, its center coordinates and its area is recorded.  Then
# the sum is taken over the areas of subrectangles having their center
# within any of the original rectangles.  See picture below.
# This is essentially the surface integral of the OR'ed characteristic
# funtions over the xy-plane.

# Find the total area of N (possibly overlapping) rectangles.
sub rectangle_area (@vertices) {
    # Find grid subrectangles: center and area.
    my $subrect = subrect(@vertices);
    # Create characteristic functions for all given rectangles.
    my @chi = pairmap {gen_chi($a, $b)} @vertices;

    # Get the sum of subrectangle areas within original rectangles.
    reduce {$a + $b->[1] * any {$_->($b->[0]->@*)} @chi} 0, @$subrect;
}

# Generate the characteristic function for a rectangle with given bottom
# left and top right vertices.
sub gen_chi ($bl, $tr) {
    sub ($x, $y) {
        $bl->[0] <= $x &&
        $x <= $tr->[0] &&
        $bl->[1] <= $y &&
        $y <= $tr->[1];
    }
}

# For N given rectangles, record center coordinates and area for all
# subrectangles build from the rectangles' coordinate grid.
sub subrect (@vertices) {
    my @x = sort {$a <=> $b} map $_->[0], @vertices;
    my @y = sort {$a <=> $b} map $_->[1], @vertices;

    gather {
        for (my $ix = 0; $ix < $#x; $ix++) {
            my $dx = $x[$ix + 1] - $x[$ix];
            for (my $iy = 0; $iy < $#y; $iy++) {
                my $dy = $y[$iy + 1] - $y[$iy];
                take [[$x[$ix] + $dx / 2, $y[$iy] + $dy / 2],
                    $dx * $dy];
            }
        }
    }
}


### Examples and tests

# Example 1:
# Original rectangles in bold lines within the surrounding rectangle and
# the product of the subrectangle's area and the OR'ed characteristic
# functions inside the subrectangle.
#
# 4 ┌───┲━━━━━━━┯━━━━━━━┓
#   │   ┃       │       ┃
# 3 │ 0 ┃   4   │   4   ┃
#   │   ┃       │       ┃
# 2 ┢━━━╋━━━━━━━╅───────┨
#   ┃   ┃       ┃       ┃
# 1 ┃ 2 ┃   4   ┃   4   ┃
#   ┃   ┃       ┃       ┃
# 0 ┡━━━╋━━━━━━━╃───────┨
#   │ 0 ┃   2   │   2   ┃
# -1└───┺━━━━━━━┷━━━━━━━┛
#  -1   0   1   2   3   4

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is rectangle_area([-1, 0], [2, 2], [0, -1], [4, 4]), 22, 'example 1';
        is rectangle_area([-3, -1], [1, 3], [-1, -3], [2, 2]), 25, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is rectangle_area([0, 0], [1, 1], [1, 1], [2, 2], [2, 2], [3, 3],
            [2, 2], [4, 4]), 6, 'four squares';
        is rectangle_area([0, 0], [1, 1], [1, 0], [2, 1]), 2,
            'some empty subrectangles';
	}

    done_testing;
    exit;
}
