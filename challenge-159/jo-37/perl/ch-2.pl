#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Utils qw(fsum gcd ceil);
use Math::Trig 'pi2';

# For testing only:
use Math::Prime::Util;

use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Print µ(N).

EOS


### Input and Output

# Round to integer.
printf "%.0f\n", moebius(shift);


### Implementation

# The Möbius function is provided by the awesome Math::Prime::Util.
# Using it for cross-checking another implementation taken from
# Wikipedia:
#
# µ(n) equals the sum of all primitive n-th roots of unity.
# Though this is really funny, it's rather inefficient.
#
# Some considerations:
# - There are no primitive roots with a zero imaginary part for n > 2.
# - If a number z is a n-th root, then the conjugate number z* is a root,
#   too.  And it is a different number for nonzero imaginary parts.
# - From
#   z + z* = 2 Re z
#   it follows, that positive and negative imaginary parts cancel out
#   and the real parts double.
# Thus it is sufficient to take twice the sum of the real parts of
# primitive roots with a positive imaginary part.  No complex arithmetic
# is required.
#
# Remember:
# exp(2πi k/n) are the n-th roots of unity and
# exp(iϑ) = cos(ϑ) + i sin(ϑ)

sub moebius ($n) {
    # Treat the special cases
    return 1 if $n == 1;
    return -1 if $n == 2;

    2 * fsum map cos(pi2 * $_ / $n),
        grep gcd($_, $n) == 1, 1 .. ceil($n / 2) - 1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is moebius(5), float(-1), 'example 1';
        is moebius(10), float(1), 'example 2';
        is moebius(20), float(0), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        for my $n (1 .. 128) {
            is moebius($n),
                float(Math::Prime::Util::moebius($n)), "n=$n";
        }
	}

    done_testing;
    exit;
}
