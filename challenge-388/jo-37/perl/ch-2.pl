#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util 'factorial';


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
    $0 - number of derangements

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        a positive integer

    EOS
}


### Input and Output

say derangements(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/08/28/ch-388.html#task-2

sub derangements {
    int((factorial(shift) + 1) / exp(1));
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = derangements(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1], 0, 'example 1'],
            [[2], 1, 'example 2'],
            [[3], 2, 'example 3'],
            [[4], 9, 'example 4'],
            [[5], 44, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
