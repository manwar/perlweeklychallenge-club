#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(todigits fromdigits);
use List::MoreUtils 'indexes';
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [M N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print the found numbers instead of the count thereof

M N
    find integers created by M divisible by N

EOS


### Input and Output

main: {
    my @like_num = like_num(@ARGV);
    say $verbose ? "@like_num" : scalar @like_num;
}


### Implementation

# Take the indices of 1-bits in the binary representation of the numbers
# from 1 to 2 ** length($m) - 2 (representing all valid subsequences) as
# slice arguments for the decimal digits of $m and collect all results
# divisible by $n.  Return the found unique numbers.
sub like_num ($m, $n) {
    my @digits = todigits $m;
    my %divisible;
    @divisible{
        grep !($_ % $n),
        map fromdigits([@digits[indexes {$_} todigits $_, 2, @digits]]),
        1 .. 2 ** @digits - 2
    } = ();

    keys %divisible;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is scalar(like_num(1234, 2)), 9, 'example 1';
        is scalar(like_num(768, 4)), 3, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is scalar(like_num(135, 2)), 0, 'no even subnumber';
        is scalar(like_num(12345, 1)), 2**5 - 2, 'count valid subnumbers';
        is scalar(like_num(2222, 2)), 3, 'count numbers only once';
	}

    done_testing;
    exit;
}
