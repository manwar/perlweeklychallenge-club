#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'divisor_sum';
use experimental 'signatures';

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [n]

-examples
    run the examples from the challenge
 
n
    print the first n Chowla numbers

EOS


### Input and Output

say join ', ', map chowla($_), 1 .. $ARGV[0];


### Implementation

# Return the n-th Chowla number as the sum of n's nontrivial divisors.
# The trivial divisors are 1 and n, which need to be subtracted from the
# sum of all divisors.  For n = 1 these two numbers coincide and thus
# only one subtrahend shall be applied.
sub chowla ($n) {
    divisor_sum($n) - $n - ($n > 1);
}


### Examples and tests

sub run_tests {
    my $n;
    is chowla(++$n), $_, "chowla($n) = $_" for
        (0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21);

    done_testing;
    exit;
}
