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

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - Task Title

    usage: $0 [-examples] [-tests] [-verbose] [ARR1 ARR2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    ARR1 ARR2
        arrays of whitespace-separated words.

    EOS
}


### Input and Output

say +(qw(true false))[!equal_list(map [split /\s+/], @ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/15/ch-373.html#task-1

sub equal_list ($arr1, $arr2) {
    local $" = '';

    "@$arr1" eq "@$arr2";
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = equal_list(@$args);
        is $result, $expected,
            qq{$name: (@{[map "(@$_)", @$args]}) -> } . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[["a", "bc"], ["ab", "c"]], T(), 'example 1'],
            [[["a", "b", "c"], ["a", "bc"]], T(), 'example 2'],
            [[["a", "bc"], ["a", "c", "b"]], F(), 'example 3'],
            [[["ab", "c", ""], ["", "a", "bc"]], T(), 'example 4'],
            [[["p", "e", "r", "l"], ["perl"]], T(), 'example 4'],
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
