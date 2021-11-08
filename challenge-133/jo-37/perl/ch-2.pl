#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(factor_exp vecsum todigits);
use Coro::Generator;
use experimental 'signatures';

our ($tests, $base);
$base //= 10;
die "invalid base: $base" unless $base > 1;

run_tests() if $tests;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-tests] [-base=B] [N]

-tests
    run some tests

-base=B
    find Smith numbers for base B. Default: 10

N
    print the first N Smith numbers.
   
EOS


### Input and Output

main: {
    # Create a generator for Smith numbers.
    my $smith = generator {
        for (my $n = 1;; $n++) {
            yield $n if is_smith($n, $base);
        }
    };

    say join ', ', map $smith->(), 1 .. shift;
}


### Implementation

# Math::Prime::Util has everything we need to solve this task:
# - convert a number into its representation for a given base
# - find all factors (and their multiplicity) of a number 
# - sum the elements of a list
# Excluding primes as trivial cases of Smith numbers.
#
# See http://oeis.org/A006753

sub is_smith ($n, $base=10) {
    vecsum(todigits $n, $base) ==
        vecsum map {$_->[1] * vecsum todigits $_->[0], $base}
        grep {$_->[0] != $n} factor_exp $n;
}


### Examples and tests

sub run_tests {
    is is_smith(4937775), T(), 'Smith\'s phone number'; 
    is is_smith(22), T(), '22(10)';
    is is_smith(0x22, 16), T(), '22(16)';
    is is_smith(24), F(), 'counter example';
    is is_smith(29), F(), 'excluded prime';

    # This takes about 25 s:
    is scalar(grep is_smith($_), 1e6 .. 1e7 - 1),
        248483, 'number of 7-digit Smith numbers according to OEIS';

    done_testing;
    exit;
}
