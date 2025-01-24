#!/usr/bin/perl

use v5.26;
use Test2::V0 '!array';
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use bigint;
use Math::Prime::Util 'is_prime';
use List::Util 'reductions';
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental 'signatures';

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - binary prefix

    usage: $0 [-examples] [-tests] [B...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    B...
        list of binary digits

    EOS
}


### Input and Output

say join ', ', map +(qw(false true))[$_], binary_prefix(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/24/ch-305.html#task-1

sub binary_prefix {
    map {is_prime($_) <=> 0} reductions {2 * $a + $b} @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    # convert a list of numbers into a ref to an array of
    # Test2::Compare::Number objects
    state sub numarr {
        [map number($_), @_];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [binary_prefix(@$args)];
        is $result, numarr(@$expected), "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 0, 1], [0, 1, 1], 'example 1'],
            [[1, 1, 0], [0, 1, 0], 'example 2'],
            [[1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1],
                [0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
                'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 5;
        is [binary_prefix(0, 0)], numarr(0, 0), '0, 0';
        is [binary_prefix(0, 1)], numarr(0, 0), '0, 1';
        is [binary_prefix(1, 0)], numarr(0, 1), '1, 2';
        is [binary_prefix(1, 1)], numarr(0, 1), '1, 3';

        my @me = (2, 3, 5, 7, 13, 17, 19, 31, 61, 89, 107, 127, 521);
        my @expected = (0) x $me[-1];
        @expected[map $_ - 1, @me] = (1) x @me;
        is [binary_prefix((1) x $me[-1])], numarr(@expected),
            'Mersenne primes';
        
    }) : pass 'skip tests';

    exit;
}
