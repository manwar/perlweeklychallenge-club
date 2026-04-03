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
    $0 - max odd binary

    usage: $0 [-examples] [-tests] [BIN]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    BIN
        a binary string

    EOS
}


### Input and Output

say max_odd_binary(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/04/02/ch-367.html#task-1

sub max_odd_binary ($str) {
    my $ones = $str =~ tr/1//;
    die unless $ones;

    '1' x ($ones - 1) . '0' x (length($str) - $ones) . '1';
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = max_odd_binary(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["1011"], "1101", 'example 1'],
            [["100"], "001", 'example 2'],
            [["111000"], "110001", 'example 3'],
            [["0101"], "1001", 'example 4'],
            [["1111"], "1111", 'example 5'],
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
