#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use List::Util 'product';


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
    $0 - reversible numbers

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        print reversible numbers up to N

    EOS
}


### Input and Output

say join ', ', grep reversible_number($_), 1 .. shift;


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/15/ch-176.html#task-2

sub reversible_number ($n) {
    product map $_ % 2, split //, $n + reverse $n;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        plan 1;
        my @rn = grep reversible_number($_), 1 .. 100;
        is \@rn, [10, 12, 14, 16, 18, 21, 23, 25, 27,
            30, 32, 34, 36, 41, 43, 45, 50, 52,
            54, 61, 63, 70, 72, 81, 90], 'example';

    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
