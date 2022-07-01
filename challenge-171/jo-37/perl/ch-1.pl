#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(divisor_sum foroddcomposites);
use Coro::Generator;
use experimental 'signatures';

our ($tests, $examples, $div);
$div ||= 2;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-div=D
    Limit the result to numbers not divisable by D.
    Default: 2, i.e. all odd numbers.

N
    Print the first N odd abundant numbers not divisable by D

EOS


### Input and Output

main: {
    my $abundant = gen_odd_abundant_div($div);
    say for map $abundant->(), 1 .. shift;
}


### Implementation

# Build a generator for odd abundant numbers not divisable by a given
# number C.
# Generating just odd abundant number appears to be simple, so digging a
# bit deeper into the matter.
# At first glance, all numbers seem to be multiples of 5 (which is easy
# to check in a base 10 representation) and at second glance, they seem
# to be multiples of 3.  But that is not true: 81081 is the first number
# not divisable by 5.  This number is relatively small compared to
# 5391411025, the first number not divisable by 3.  To find such special
# numbers, the generator has an argument specifying a factor that shall
# not be part of the numbers in the resulting sequence.
sub gen_odd_abundant_div ($d) {
	generator {
        # Need to check odd composite numbers only.
        foroddcomposites {
            yield $_ if $_ % $d && 2 * $_ < divisor_sum $_;
        } 2 ** 48; # Practically an endless loop
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $abundant_odd = gen_odd_abundant_div(2);
        is [map $abundant_odd->(), 1 .. 38],
        [945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985,
            6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505, 8925,
            9135, 9555, 9765, 10395, 11025, 11655, 12285, 12705, 12915,
            13545, 14175, 14805, 15015, 15435, 16065, 16695, 17325,
            17955], 'A005231';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $abundant_5 = gen_odd_abundant_div(5);
        is $abundant_5->(), 81081, 'not divisable by 5, see A064001';

        skip "long running test";
        my $abundant_3 = gen_odd_abundant_div(3);
        # Takes more than 30 min on this machine:
        is $abundant_3->(), 5391411025, 'not divisable by 3, see A115414';
	}

    done_testing;
    exit;
}
