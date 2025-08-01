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

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - odd letters

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say +(qw(true false))[!odd_letters(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/01/ch-332.html#task-2

sub odd_letters {
    shift !~ /
    (.)
    (?!(?=(.*))(\1.+(?=\g{-2}$)|(?<=(?=x^|(?-1)).)))
    ((??{qr([^$1]*)})\1)
    (?:(?-1){2})*
    (?!.*\1)
    /x;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = odd_letters(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["weekly"], F(), 'example 1'],
            [["perl"], T(), 'example 2'],
            [["challenge"], F(), 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["abccbabac"], T(), 'all multiple'],
            [["abccbababc"], F(), 'all multiple, single even'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
