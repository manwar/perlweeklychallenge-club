#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
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

usage() unless @ARGV > 1;

sub usage {
    die <<~EOS;
    $0 - shift grid

    usage: $0 [-examples] [-tests] [K M]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    K
        number of shifts

    M
        a matrix in any form accepted by the PDL string constructor,
        e.g. '1 2 3; 4 5 6; 7 8 9'
    EOS
}


### Input and Output

say shift_grid(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/02/ch-354.html#task-2

sub shift_grid ($k, @m) {
    my $grid = long @m;
    $grid->flat->rotate($k)->reshape($grid->dims);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = shift_grid(@$args);
        pdl_is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, long([1, 2, 3], [4, 5, 6], [7, 8, 9])],
               long([9, 1, 2], [3, 4, 5], [6, 7, 8]), 'example 1'],
            [[1, long([10, 20], [30, 40])],
               long([40, 10], [20, 30]), 'example 2'],
            [[1, long([1, 2], [3, 4], [5, 6])],
               long([6, 1], [2, 3], [4, 5]), 'example 3'],
            [[5, long([1, 2, 3], [4, 5, 6])],
               long([2, 3, 4], [5, 6, 1]), 'example 4'],
            [[1, long([1, 2, 3, 4])],
               long([4, 1, 2, 3]), 'example 5'],
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
