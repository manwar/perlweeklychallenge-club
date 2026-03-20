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

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - alphabet index digit sum

    usage: $0 [-examples] [-tests] [STR K]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    K
        a non-negative integer

    EOS
}


### Input and Output

say alpha_index_digit_sum(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/20/ch-365.html#task-1

sub alpha_index_digit_sum ($str, $k) {
    my $d = join '', map ord() - ord('a') + 1, split //, $str;
    $d = sum split //, $d for 1 .. $k;
    $d;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = alpha_index_digit_sum(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['abc',  1], 6, 'example 1'],
            [['az',   2], 9, 'example 2'],
            [['cat',  1], 6, 'example 3'],
            [['dog',  2], 8, 'example 4'],
            [['perl', 3], 6, 'example 4'],
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
