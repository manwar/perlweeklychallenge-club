#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use bigint;

use Math::Prime::Util qw(factor);


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
    $0 - home prime

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        an integer larger than 1

    EOS
}


### Input and Output

say home_prime(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/15/ch-168.html#task-2

sub home_prime ($n) {
    while () {
        my @factor = factor $n;
        return shift @factor if @factor == 1;
        $n = join '', @factor;
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        plan 1;
        is home_prime(10), number(773), 'Example';
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
