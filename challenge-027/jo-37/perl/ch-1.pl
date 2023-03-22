#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use warnings FATAL => 'all';
use PDL;
use PDL::NiceSlice;
use Data::Dump qw(dd pp);
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 8;
usage: $0 [-examples] [-tests] [--] [A B C D P Q R S]

-examples
    run the examples from the challenge
 
-tests
    run some tests

A B C D P Q R S
    coordinates of four points defining two lines

EOS


### Input and Output

say "(@{line_intersection(@ARGV)})";


### Implementation

# Taking the eight coordinates as two point pairs.
# A line can be described by one of its points and a vector orthogonal
# to its direction as nᵀ(x-p) = 0. Solving this equation for two lines,
# where the orthogonal vectors n form a matrix A leading to the equation
# A x = b.  Solving this linear equation.
# In the task description the given points are named "end points".
# Maybe this is meant as an additional constraint for the intersection
# lying within the end points of both lines.  Such an additional check
# could be easily added but is omitted here.
sub line_intersection {
    # Collect coordinates into a 2x2x2 piddle.
    my $lines = pdl([[$_[0], $_[1]], [$_[2], $_[3]]],
        [[$_[4], $_[5]], [$_[6], $_[7]]])->xchg(0, 1);
    # A 2x2 rotation matrix:
    state $rot = pdl [0, 1], [-1, 0];
    # Build orthogonal vectors as the rotated directions.
    my $a = ($lines((1)) - $lines((0))) x $rot;
    # Extract the starting points.
    my $p = $lines((0))->xchg(0, 1);
    # The right hand side. 
    my $b = ($a x $p)->diagonal(0,1);
    # Find the intersection:
    my $x = lu_backsub(lu_decomp($a), $b);

    $x->clump(-1)->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
    }

    SKIP: {
        skip "tests" unless $tests;
        
        is line_intersection(1, 2, 5, 4, 2, 5, 4, 1), [3, 3], 'symmetric test';
        is line_intersection(-1, -1, 1, 1, -1, 1, 1, -1), [0, 0], 'origin 1';
        is line_intersection(-1, 1, 1, -1, -1, -1, 1, 1), [0, 0], 'origin 2';
        is line_intersection(2, 4, 8, 7, 3, 6, 7, 2), [4, 5], 'asymmetric test';
	}

    done_testing;
    exit;
}
