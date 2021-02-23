#!/usr/bin/perl -s

use v5.16;
use PDL;
use Test2::V0 '!float';
use Math::Prime::Util 'divisors';
use experimental qw(signatures postderef);

our ($tests, $examples, $verbose, $alt);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-alt] [n1 n2 ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

-alt
    produce an alternative solution for non-square matrices

n1 n2 ...
    numbers to roll into a matrix

EOS


### Input and Output

say scalar roll(\@ARGV, $alt);


### Implementation

# Get matrix form: minimum difference between number of rows and
# columns.
sub form :prototype($) ($n) {
    my @d = divisors $n;

    # Difference of the "middle" divisors.
    $d[@d / 2] - $d[-(@d / 2 + 1)];
}

# Roll a matrix from an array of numeric values.
sub roll ($arr, $alt=0) {

    # Create the starting matrix as a single row or column from a piece
    # off the list tail, sized according to the matrix' form.  The
    # solution's orientation is predefined by the starting matrix.
    # Providing either variants.
    my $roll = pdl(splice @$arr, -(form(@$arr) + 1))
        ->slice($alt ? '*,-1:0' : 'X,*')->sever;
    say $roll if $verbose;

    while (@$arr) {
        # Left-rotate the current matrix and add an apt piece off the
        # list tail.
        $roll = $roll
            ->slice('-1:0')->xchg(0,1)
            ->glue(1, pdl splice @$arr, -$roll->dim(1))
            ->sever;
        say $roll if $verbose;
    }

    # Return the solution as an AoA or as the piddle itself depending on
    # the context.
    wantarray ? $roll->unpdl->@* : $roll;
}


### Examples and tests

sub run_tests {
    local $alt;
    SKIP: {
        skip "examples" unless $examples;

        is [roll [1 .. 4]], [[4, 3], [1, 2]], 'example 1';
        is [roll [1 .. 6]], [[6, 5, 4], [1, 2, 3]], 'example 2a';
        is [roll [1 .. 6], 1], [[5, 4], [6, 3], [1, 2]], 'example 2b';
        is [roll [1 .. 12]],
            [[9, 8, 7, 6], [10, 11, 12, 5], [1, 2, 3, 4]],
            'example 3a';
        is [roll [1 .. 12], 1],
            [[8, 7, 6], [9, 12, 5], [10, 11, 4], [1, 2, 3]],
            'example 3b';
    }

    SKIP: {
        skip "tests" unless $tests;

        is form(12 * 12), 0, 'form 0';
        is form(11 * 12), 1, 'form 1';
        is form(12 * 14), 2, 'form 2';
        is form(9 * 12), 3, 'form 3';
        is form(137), 136, 'form prime - 1';

        is [roll [1 .. 3]], [[1 .. 3]], 'prime';
        is [roll [1 .. 3], 1], [[3], [2], [1]], 'alt prime';
        is [roll [1 .. 9]], [[7, 6, 5], [8, 9, 4], [1, 2, 3]], 'odd size';
        is [roll [1]], [[1]], 'single element';
	}

    done_testing;
    exit;
}
