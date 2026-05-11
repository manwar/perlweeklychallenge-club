#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use List::Util 'max';


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
    $0 - largest substring

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

say largest_substring(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/08/ch-372.html#task-2

sub largest_substring {
    my $l = -1;
    shift =~ /(.)(.*)\1(?{$l = max $l, length $2})(*FAIL)/;

    $l;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = largest_substring(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["aaaaa"], 3, 'example 1'],
            [["abcdeba"], 5, 'example 2'],
            [["abbc"], 0, 'example 3'],
            [["abcaacbc"], 4, 'example 4'],
            [["laptop"], 2, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is largest_substring("abcde"), -1, "no pair";
    }) : pass 'skip tests';

    exit;
}
