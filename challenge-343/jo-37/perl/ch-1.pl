#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'min';

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
    $0 - zero friend

    usage: $0 [-examples] [-tests] [-verbose] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of numbers

    EOS
}


### Input and Output

say zero_friend(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/17/ch-343.html#task-1


sub zero_friend {
    min map abs, @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = zero_friend(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[4, 2, -1, 3, -2], 1, 'example 1'],
            [[-5, 5, -3, 3, -1, 1], 1, 'example 2'],
            [[7, -3, 0, 2, -8], 0, 'example 3'],
            [[-2, -5, -1, -8], 1, 'example 4'],
            [[-2, 2, -4, 4, -1, 1], 1, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
