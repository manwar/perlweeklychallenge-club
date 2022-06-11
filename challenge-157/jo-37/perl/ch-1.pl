#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'reduce';
use experimental 'postderef';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N1 ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 ...
    Calculate the Pythagorean means for the given numbers

EOS


### Input and Output

# Present the means with a precision of one decimal digit.
printf "AM = %.1f GM = %.1f HM = %.1f\n", pythagorean_means(@ARGV);


### Implementation

# Feed the number of elements, the sum, the product and the sum of the
# reciprocals of the given list into an anonymous sub to calculate
# the requested means.
# The examples call for results with a precision of one decimal digit,
# thus not spending any effort to produce exact results.
sub pythagorean_means {
    sub {($_[1] / $_[0], $_[2] ** (1 / $_[0]), $_[0] / $_[3])}->(
        scalar @_,
        (reduce {[$a->[0] + $b, $a->[1] * abs($b), $a->[2] + 1 / $b]}
        [0, 1, 0], @_)->@*
    );
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [pythagorean_means(1, 3, 5, 6, 9)],
        [float(4.8, precision => 1), float(3.8, precision => 1),
            float(2.8, precision => 1)], 'example 1';

        is [pythagorean_means(2, 4, 6, 8, 10)],
        [float(6.0, precision => 1), float(5.2, precision => 1),
            float(4.4, precision => 1)], 'example 2';

        is [pythagorean_means(1, 2, 3, 4, 5)],
        [float(3.0, precision => 1), float(2.6, precision => 1),
            float(2.2, precision => 1)], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [pythagorean_means((1000) x 16)],
            [float(1000, precision => 1), float(1000, prescision => 1),
                float(1000, precision => 1)], 'large product';
            
        is [pythagorean_means(2, 3, 4)], array {item 0 => 3; etc;},
            'exact AM';
        is [pythagorean_means(20, -18, 75)], array {item 1 => 30; etc;},
            'exact GM with negative product';
	}

    done_testing;
    exit;
}
