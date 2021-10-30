#!/usr/bin/perl -s

use v5.16;
use Math::Prime::Util qw(todigits lucasu);
use List::MoreUtils 'reduce_0';
use Memoize qw(memoize flush_cache);
use Benchmark 'cmpthese';
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $benchmark);
memoize('count_fib_seq');

run_tests() if $tests || $examples || $benchmark;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-benchmark] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-benchmark
    compare a recursive counting implementation with a brute force scan.

N
    Count Fibonacci subsequences that give a sum of N.

EOS


### Input and Output

say count_fib_seq($ARGV[0]);


### Implementation

# Try Fibonacci numbers F(k) starting with the k-th element, utilizing
# F(k) == lucas_u(1, -1, k):
# - Return the count if if F(k) is larger than or equal to N.
# - Add to the count the number of Fibonacci sequences that give a sum
#   of N - F(k), starting with F(k + 1) by recursion.
# Note: The XS implementation of "lucasu" is much faster than its
# memoizing counterpart.

sub count_fib_seq ($n, $k = 2) {
    my $count = 0;
    while () {
        my $fib = lucasu 1, -1, $k;
        return $count + ($fib == $n) if $fib >= $n;
        $count += count_fib_seq($n - $fib, ++$k);
    }
}

# An alternative brute force approach:
# Try all Fibonacci subsequences for a matching sum.  Taking the binary
# digits of the iterator variable as selectors for corresponding
# Fibonacci numbers.
# This was intended as a cross check for the counting implementation.

sub scan_fib_seq ($n) {
    my (@fib, $f) = (1, 1);
    push @fib, $f while ($f = $fib[-2] + $fib[-1]) <= $n;
    shift @fib;

    scalar grep {
        $n == reduce_0 {$a += $fib[$_] * $b} todigits($_, 2, @fib)
    } 1 .. 2 ** @fib - 1;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_fib_seq(16), 4, 'example 1';
        is count_fib_seq(9), 2, 'example 2';
        is count_fib_seq(15), 2, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        grep {
            count_fib_seq($_) != scan_fib_seq($_) and !fail "$_ failed";
        } 0 .. 100 or pass 'cross check';
	}

    SKIP: {
        skip "benchmark" unless $benchmark;

        cmpthese(0, {
                scan => sub {scan_fib_seq(1000)},
                count => sub {
                    flush_cache('count_fib_seq');
                    count_fib_seq(1000);
                }
            });
    }

    done_testing;
    exit;
}
