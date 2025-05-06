#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;

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
    $0 - maximum count

    usage: $0 [-examples] [-tests] [--] [I...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    I...
        list of integers

    EOS
}


### Input and Output

say max_count(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/09/ch-320.html#task-1


sub max_count {
    my $s = long(@_)->clip(-1, 1);
    (sum(abs $s) + abs(sum $s)) / 2;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = max_count(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[-3, -2, -1, 1, 2, 3], 3, 'example 1'],
            [[-2, -1, 0, 0, 1], 2, 'example 2'],
            [[1, 2, 3, 4], 4, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is max_count(0, 0, 0), 0, 'zeroes only';
        is max_count(-1, -2, -3), 3, 'negative only';
        is max_count(0 .. 99, -99 .. 0), 99, 'ninty nine';
    }) : pass 'skip tests';

    exit;
}
