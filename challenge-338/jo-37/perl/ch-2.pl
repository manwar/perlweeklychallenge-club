#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;

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
    $0 - max distance

    usage: $0 [-examples] [-tests] [-verbose] [--] [L...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    L...
        list of integer lists in a form like 'a,b,c;d,e' or '[a b c] [d e]'

    EOS
}


### Input and Output

say max_distance(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/09/12/ch-338.html#task-2

sub max_distance {
    state $diff = long -1, 1;
    state $sel = indx [0, 1, 0], [0, 0, 1];
    $PDL::undefval = badvalue long;
    (my $m = long @_)->badflag(1);
    my $mm = cat +($m->minmaximum)[0, 1];
    my $mm2 = maximum_n_ind $mm * $diff(*1), 2;
    my $cand = $mm2->cat($mm->index1d($mm2))
        ->index1d($sel)->xchg(0, 1)->inner($diff);

    $cand(,1)->where($cand(,0))->max;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = max_distance(@$args);
        is $result, $expected,
            "$name: (@{[map qq([@$_]), @$args]}) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[4, 5, 7], [9, 1, 3, 4]], 6, 'example 1'],
            [[[2, 3, 5, 4], [3, 2, 5, 5, 8, 7]], 6, 'example 2'],
            [[[2, 1, 11, 3], [2, 5, 10, 2]], 9, 'example 3'],
            [[[1, 2, 3], [3, 2, 1]], 2, 'example 4'],
            [[[1, 0, 2, 3], [5, 0]], 5, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[[2, 5, 10], [5, 6, 7], [1, 4, 9]], 9, 'max_1/min_1'],
            [[[1, 5, 10], [5, 6, 7], [2, 4, 7]], 8, 'max_1/min_2'],
            [[[1, 5, 10], [5, 6, 7], [3, 4, 9]], 8, 'max_2/min_1'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
