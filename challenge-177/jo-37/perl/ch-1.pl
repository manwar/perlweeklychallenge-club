#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - Damm validation

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        a non-negative integer

    EOS
}


### Input and Output

say damm(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/15/ch-177.html#task-1

sub damm ($n) {
    state $m = [
        [0, 3, 1, 7, 5, 9, 8, 6, 4, 2],
        [7, 0, 9, 2, 1, 5, 4, 8, 6, 3],
        [4, 2, 0, 6, 8, 7, 1, 3, 5, 9],
        [1, 7, 5, 0, 9, 8, 3, 4, 2, 6],
        [6, 1, 2, 3, 0, 4, 5, 9, 7, 8],
        [3, 6, 7, 4, 2, 0, 9, 5, 8, 1],
        [5, 8, 6, 9, 7, 2, 0, 1, 3, 4],
        [8, 9, 4, 5, 3, 6, 2, 0, 1, 7],
        [9, 4, 3, 8, 6, 1, 7, 2, 0, 5],
        [2, 5, 8, 1, 4, 3, 6, 7, 9, 0],
    ];
    my $x = 0;
    for my $y (split //, $n) {
        $x = $m->[$x][$y];
    }
    0 + !$x;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        plan 2;
        is damm(5724), 1, 'Example 1';
        is damm(5727), 0, 'Example 2';
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
