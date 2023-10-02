#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV >= 3;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of at least three numbers

EOS


### Input and Output

say max_prod(@ARGV);


### Implementation

# There are only two candidates for the maximum product of three
# elements:
# - the product of the three largest elements
# - the product of the two smallest elements with the largest
sub max_prod {
    # For the sake of convenience, sort the elements.
    my @s = sort {$a <=> $b} @_;
    my $left = $s[0] * $s[1] * $s[-1];
    my $right = $s[-3] * $s[-2] * $s[-1];

    $left > $right ? $left : $right;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is max_prod(3, 1, 2), 6, 'example 1';
        is max_prod(4, 1, 3, 2), 24, 'example 2';
        is max_prod(-1, 0, 1, 3, 1), 3, 'example 3';
        is max_prod(-8, 2, -9, 0, -4, 3), 216, 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;

        is max_prod(-1, -2, -3, -4, -5), -6, 'all negative';
        is max_prod(1, 2, 3, 4, -5), 24, 'one negative';
        is max_prod(1, 2, -3, -4, 4, 5), 60, 'left wins';
        is max_prod(1, -2, 3, -4, 4, 5), 60, 'right wins';
	}

    done_testing;
    exit;
}
