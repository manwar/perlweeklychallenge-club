#!/usr/bin/perl -s

use v5.16;
use Math::Utils qw(gcd flipsign);
use List::Util qw(none first);
use List::MoreUtils 'pairwise';
use Data::Dump qw(dd pp);
use Carp;
use Test2::V0;
use experimental qw(signatures postderef);

# The task does not specify the data type of the given points.  Since
# the examples use integers, this implementation presumes integer
# coordinates too.  Using floating point coordinates would lead to a
# quite different implementation where rounding were the key challenge.
# This implementation will silently fail in most cases when given
# non-integer coordinates.
#
# Using references to arrays holding the coordinates as the
# representation of points.  This implementation is independent of the
# vector space's dimension in use.  Any dimension > 0 may be used.

our ($selftest, $tests, $examples, $verbose);

run_tests() if $selftest || $tests || $examples; # does not return

say(<<EOS), exit unless @ARGV;
usage: $0 [-examples] [-tests] [-selftest] [-verbose] [point ...]

-examples
   run the examples from the challenge
 
-tests
   run some tests

-selftest
   run some self-tests

-verbose
   enable trace output

point ...
   coordinates of points in the form "x,y,..."

EOS

# convert @ARGV to point list
my @points = get_points(@ARGV);
say 'points: ', pp @points if $verbose;

# Process input data
say scalar max_points_in_line(@points);

# convert points given as x,y,... to a list of array references
sub get_points {
    map {[split ',']} @_
}

# Get the "canonical direction" between two integral points:
# - nonzero components have no common divisor > 1
# - the first nonzero component is positive
# - a single nonzero component is normalized to 1
# - components are joined into a string
# This provides a unique string representation of the direction between
# any two points with integral coordinates.
sub canon_dir ($p, $q) {

    # Get the raw direction between the two points.
    my @dir = pairwise {$b - $a} $p->@*, $q->@*;

    # Sanity check. 
    croak "points are identical" if none {$_} @dir;

    # Eliminate (common) factors.
    my @nonzero = grep $_, @dir;
    my $cf = @nonzero == 1 ? $nonzero[0] : gcd @nonzero;
    $_ /= $cf foreach @dir;

    # Turn the first nonzero component into a positive number.
    my $first = first {$_} @dir;
    $_ = flipsign $_, $first foreach @dir;

    join ',', @dir;
}

# Find the maximum number of points that reside on a common line.
# Returns not just the number of points but the points themselves.
sub max_points_in_line {

    # Provide an appropriate result in case of less than two
    # points given.
    my @points_in_line = @_ ? $_[0] : ();

    # Loop while there are enough points for a new maximum.
    while (@_ > @points_in_line) {

        # Get the first point - destructively.
        my $p = shift;

        # A hash to collect points per direction.
        my %dirs;

        # Loop over the remaining points.
        for my $q (@_) {

            # Get the canonical direction between the point pair.
            my $dir = canon_dir $p, $q;

            # The canonical direction is the key for the list of points
            # on the line going through the first point in the specific
            # direction.  Initialize an undefined list with the first
            # point.
            $dirs{$dir} ||= [$p];

            # Add the current second point to the direction's point
            # list.
            push $dirs{$dir}->@*, $q;

            # Record the current point list if it forms a new maximum.
            if ($dirs{$dir}->@* > @points_in_line) {
                @points_in_line = $dirs{$dir}->@*;

                say "max at ", pp($p), " in direction ($dir): ",
                     pp @points_in_line if $verbose;
            }
        }
    }
    say 'points in line: ', pp @points_in_line if $verbose;

    @points_in_line;
}

sub run_tests {
    SKIP: {
        skip "self test", 5 unless $selftest;

        is canon_dir([1, 2], [19, 14]), '3,2', 'normalize';
        is canon_dir([19, 14], [1, 2]), '3,2', 'switch orientation';
        is canon_dir([1, 3], [1, -7]), '0,1', 'parallel to y';
        is canon_dir([3, 11], [-2, 11]), '1,0', 'parallel to x';
        like dies {canon_dir([1, 1], [1, 1])}, qr/identical/, 'same point';
    }

    SKIP: {
        skip "examples", 2 unless $examples;
        # The result in scalar context gives the number of points as requested.
        is scalar(max_points_in_line [1,1], [2,2], [3,3]),
            3, 'Example 1';
        is scalar(max_points_in_line [1,1], [2,2], [3,1], [1,3], [5,3]),
            3, 'Example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is [max_points_in_line [0, 1], [0, 2], [0, 3], [0, 4], [1, 0],
            [1, 1], [1, 2]],
            [[0, 1], [0, 2], [0, 3], [0, 4]], 'parallel to y';

        is [max_points_in_line [0, 1], [0, 2], [0, 3], [0, 4], [1, 0],
            [1, 1], [1, 2], [2, 0], [3, 0], [4, 0], [5, 0]],
            [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0]], 'parallel to x';

        is scalar(max_points_in_line [5, 3], [8, 8], [14, 18], [23, 33],
            [-7, -17]),
            5, 'all lined up';

        is [max_points_in_line [1, 1], [2, 2]], [[1, 1], [2, 2]],
            'two points';
        is [max_points_in_line [1, 1]], [[1, 1]], 'single point';
        is [max_points_in_line], [], 'no point';

        # Create a parabola.
        my @parabola = map [$_, $_ * ($_ - 1) / 2], 0 .. 10;
        say 'parabola: ', pp @parabola if $verbose;
        is scalar(max_points_in_line @parabola), 2,
            'no more than two points in line on a parabola';

        # 3-dimensional example
        my @threedim = ([0, 0, 0], [0, 0, 2], [0, 2, 0], [2, 0, 2],
            [1, 1, 1]);
        is scalar(max_points_in_line @threedim), 3, 'points in 3d';

        # Degenerated 1-d example
        is scalar(max_points_in_line [2], [3], [5]), 3, 'points in 1d';
    }

    done_testing;

    exit;
}
