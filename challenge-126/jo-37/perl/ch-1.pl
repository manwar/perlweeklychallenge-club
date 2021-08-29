#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'logint';
use Memoize;
use Benchmark 'cmpthese';
use experimental 'signatures';

our ($tests, $examples, $benchmark);
memoize('count_numbers');

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-benchmark] [N]

-examples
    run the examples from the challenge
 
-tests
    check recursive implementation against iterative results for 1 .. N.

-benchmark
    compare recursive and iterative approaches.

N
    count numbers without ones in the range 1 .. N

EOS


### Input and Output

{
    my $n = shift;
    say count_numbers($n);

    cmpthese(0, {
            recurse => sub {count_numbers($n)},
            iterate => sub {iterate($n)}
        }) if $benchmark;
}

# N = 100:
#             Rate iterate recurse
# iterate 110460/s      --    -85%
# recurse 747103/s    576%      --

# N = 10000:
#             Rate iterate recurse
# iterate   1080/s      --   -100%
# recurse 749445/s  69269%      --

# N = 1000000:
#             Rate  iterate  recurse
# iterate   9.75/s       --    -100%
# recurse 742463/s 7616134%       --


### Implementation

# Count the numbers less than or equal to $n that don't have the digit
# one in their decimal representation.

# Using a recursive, pure numeric approach.  While recursing, we need to
# distinguish between the cases when counting from zero e.g. in a block
# from 20 to 29 or counting from one, as in 1 .. 9, indicated by $z.
sub count_numbers ($n, $z=0) {
    # Do we count from zero?
    return $z if $n <= 1;

    # The integer logarithm of $n in base 10.
    my $log = logint($n, 10);

    # Break recursion for $n < 10
    return $n - !$z if $log == 0;

    # The largest power of ten less than or equal to $n.
    my $pot = 10 ** $log;

    # Get the count for all shorter numbers, propagating the zero state.
    my $count = count_numbers($pot - 1, $z);

    # There are no new numbers in the range between $pot and
    # 2 * $pot - 1.
    return $count if $n < 2 * $pot;

    # Get the leading digit.
    my $lead = int $n / $pot;

    # There may be $lead - 2 full blocks having one digit less than $n,
    # where zeros shall be counted. E.g. 20 .. 29, 30 .. 39, 40 .. 49
    # for $n = 55.
    $count += ($lead - 2) * count_numbers($pot - 1, 1) if $lead > 2;
   
    # There is a final block between $pot * $lead and $n, where zeros
    # shall be counted again. E.g. 50 .. 55 for $n = 55.
    $count += count_numbers($n - $pot * $lead, 1);
}

# Iterative approach for a cross check and benchmarking.
sub iterate ($n) {
    my $c = 0;
    !/1/ && $c++ for 1 .. $n;
    $c;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is count_numbers(15), 8, 'example 1';
        is count_numbers(25), 13, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is count_numbers($_), iterate($_),  "N=$_" for 1 .. $ARGV[0] // 50;
	}

    done_testing;
    exit;
}
