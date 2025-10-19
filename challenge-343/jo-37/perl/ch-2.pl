#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'sum';

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
    $0 - champion team

    usage: $0 [-examples] [-tests] [GRID]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    GRID
        matrix representing the results of all team pairings
        in the form R00,R01,R02,... R10,R11,R12,... ...
    EOS
}


### Input and Output

say champion_team(map [split ',', $_], @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/17/ch-343.html#task-2

sub champion_team {
    my @wins = map {sum @$_} @_;
    (sort {$wins[$a] <=> $wins[$b] || 2 * $_[$a][$b] - 1} 0 .. $#_)[-1];
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = champion_team(@$args);
        is $result, $expected,
            "$name: (@{[map qq{[@$_]}, @$args]}) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[0, 1, 1],
              [0, 0, 1],
              [0, 0, 0]], 0, 'example 1'],
            [[[0, 1, 0, 0],
              [0, 0, 0, 0],
              [1, 1, 0, 0],
              [1, 1, 1, 0]], 3, 'example 2'],
            [[[0, 1, 0, 1],
              [0, 0, 1, 1],
              [1, 0, 0, 0],
              [0, 0, 1, 0]], 0, 'example 3'],
            [[[0, 1, 1],
              [0, 0, 0],
              [0, 1, 0]], 0, 'example 4'],
            [[[0, 0, 0, 0, 0],
              [1, 0, 0, 0, 0],
              [1, 1, 0, 1, 1],
              [1, 1, 0, 0, 0],
              [1, 1, 0, 1, 0]], 2, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[[0, 1, 1, 0],
              [0, 0, 1, 0],
              [0, 0, 0, 0],
              [1, 0, 0, 0]], 0, '3 beats 0'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
