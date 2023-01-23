#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'sum';
use experimental 'postderef';
use Benchmark 'cmpthese';

our ($tests, $examples, $benchmark, $single);

run_tests() if $tests || $examples || $benchmark;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-benchmark] [-single] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-benchmark
    benchmark different branches

-single
    assume one single missing value as suggested by the examples

N...
    list of unique numbers

EOS


### Input and Output

say for find_missing($single, @ARGV);


### Implementation

# If the given unique numbers were in the range 0 .. N, then exactly one
# number would be missing and this could easily be found as the
# difference between the sum over all numbers up to N and the sum over
# the given numbers.  The examples conform to this pattern but it is not
# stated explicitly. Therefore the more efficient implementation must be
# chosen with a 'true' first argument.

sub find_missing {
    # The easy way:
    return @_ * (@_ + 1) / 2 - sum @_ if shift;

    # The hard way:
    (\my %num)->@{0 .. @_} = ();
    delete @num{@_};
    sort {$a <=> $b} keys %num;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [find_missing(-single, 0, 1, 3)], [2], 'example 1, single';
        is [find_missing(undef,   0, 1, 3)], [2], 'example 1, multi';
        is [find_missing(-single, 0, 1)],    [2], 'example 2, single';
        is [find_missing(undef,   0, 1)],    [2], 'example 2, multi';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [find_missing(undef, 4, 7, -1)], [0 .. 3], 'nothing in list';
	}

    SKIP: {
        skip "benchmark" unless $benchmark;

        is [find_missing(-single, 1 .. 1000000)], [0], 'sum';
        is [find_missing(undef,   1 .. 1000000)], [0], 'hash';

        cmpthese(0, {
                sum  => sub {find_missing(-single, 1 .. 1000000)},
                hash => sub {find_missing(undef,   1 .. 1000000)},
            });
    }

    done_testing;
    exit;
}

__DATA__
       Rate  hash   sum
hash 1.47/s    --  -97%
sum  48.2/s 3187%    --
