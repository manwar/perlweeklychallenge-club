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
    $0 - same row columns

    usage: $0 [-examples] [-tests] [M]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    M
        a square matrix in any form accepted by the PDL
        string constructor, e.g.
        '1,3,2;2,1,3;3,2,1' or
        '[1 3 2]' '[2 1 3]' '[3 2 1]'

    EOS
}


### Input and Output

say +(qw(false true))[same_row_col("@ARGV")];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/07/10/ch-381.html#task-1

sub same_row_col {
    my $m = long @_;
    my $mat = $m->glue(1, $m->transpose);
    my $num = (1 + sequence long, $m->dim(0))->dummy(0)->dummy(0);

    ($mat == $num)->reorder(0, 2, 1)->orover->and;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = same_row_col(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[long([1, 2, 3, 4],
                   [3, 4, 1, 2],
                   [2, 3, 4, 1],
                   [4, 1, 2, 3])], T(), 'example 1'],
            [[long([1])], T(), 'example 2'],
            [[long([1, 2, 5],
                   [5, 1, 2],
                   [2, 5, 1])], F(), 'example 3'],
            [[long([1, 2, 3],
                   [1, 2, 3],
                   [1, 2, 3])], F(), 'example 4'],
            [[long([1, 2, 3],
                   [3, 1, 2],
                   [3, 2, 1])], F(), 'example 5'],
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
