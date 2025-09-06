#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;


### Options and Arguments

my ($tests, $examples, $verbose, $col, $row);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'col=i'     => \$col,
    'row=i'     => \$row,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV && $col > 0 && $row > 0;

sub usage {
    die <<~EOS;
    $0 - odd matrix

    usage: $0 [-examples] [-tests] [-verbose] [--] [-col COLS -row ROWS LOC...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -col COLS
        create matrix with COLS columns

    -row ROWS
        create matrix with ROWS rows

    LOC...
        list of locations in a form like
        '[R,C],...' or 'R,C;...'

    EOS
}


### Input and Output

say odd_matrix($row, $col, @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/09/05/ch-337.html#task-2


sub odd_matrix ($row, $col, @loc) {
    my $m = zeroes long, $col, $row;
    my ($freq, $indx) = indx(@loc)->xchg(0,1)->qsort->rle;
    $freq->inplace->setvaltobad(0);
    $indx->inplace->copybad($freq);
    $m(,$indx(,(0))) .= $freq(,(0))->dummy(0);
    $m($indx(,(1))) += $freq(,(1));
    sum $m % 2;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = odd_matrix(@$args);
        is $result, $expected,
            qq($name: $args->@[0,1], (@{[map "[@$_]", $args->@[2..$#$args]]}) -> $expected);
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[2, 3 ,=> [0,1],[1,1]], 6, 'example 1'],
            [[2, 2 ,=> [1,1],[0,0]], 0, 'example 2'],
            [[3, 3 ,=> [0,0],[1,2],[2,1]], 0, 'example 3'],
            [[1, 5 ,=> [0,2],[0,4]], 2, 'example 4'],
            [[4, 2 ,=> [1,0],[3,1],[2,0],[0,1]], 8, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[2, 2 ,=> [0,0],[0,0]], 0, 'non-unique loc'],
            [[4, 3 ,=> [3,1],[2,1],[3,2],[0, 1]], 6, 'example from blog']
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
