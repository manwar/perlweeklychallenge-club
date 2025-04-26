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

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - reverse equals

    usage: $0 [-examples] [-tests] [SOURCE TARGET]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    SOURCE TARGET
        two lists of integers

    EOS
}


### Input and Output

say +(qw(true false))[!reverse_equals(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/04/25/ch-318.html#task-2


sub reverse_equals {
    my ($s, $t) = map long($_), @_;
    my $ne = which $s != $t;

    $ne->isempty || all $s($ne(-1):$ne(0)) == $t($ne(0):$ne(-1));
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = reverse_equals(@$args);
        is $result, $expected,
            qq{$name: (@{[map "[@$_]", @$args]}) -> } . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[3, 2, 1, 4], [1, 2, 3, 4]], T(), 'example 1'],
            [[[1, 3, 4], [4, 1, 3]], F(), 'example 2'],
            [[[2], [2]], T(), 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 8;
        ok  reverse_equals([2, 3, 5, 13, 11, 7, 17, 19],
            [2, 3, 5, 7, 11, 13, 17, 19]), 'std';
        ok  reverse_equals([13, 11, 7, 17, 19],
            [7, 11, 13, 17, 19]), 'empty prefix';
        ok  reverse_equals([2, 3, 5, 13, 11, 7],
            [2, 3, 5, 7, 11, 13]), 'no suffix';
        ok !reverse_equals([2, 3, 5, 11, 13, 7, 17, 19],
            [2, 3, 5, 7, 11, 13, 17, 19]), 'not reverse';
        ok  reverse_equals([13, 11, 7],
            [7, 11, 13]), 'reverse odd';
        ok  reverse_equals([17, 13, 11, 7],
            [7, 11, 13, 17]), 'reverse even';
        ok !reverse_equals([7, 11, 17],
            [7, 13, 17]), 'different elements';
        ok  reverse_equals([2, 3, 5, 7, 11, 13, 17, 19],
            [2, 3, 5, 7, 11, 13, 17, 19]), 'equal';
    }) : pass 'skip tests';

    exit;
}
