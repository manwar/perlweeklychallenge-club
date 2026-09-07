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
    $0 - rearrange binary string

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

say rearrange(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/08/21/ch-387.html#task-1

sub rearrange ($str) {
    my $count = 0;
    $count++ while $str =~ s/01/10/g;
    $count;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = rearrange(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["111000"], 0, 'example 1'],
            [["00011"],  4, 'example 2'],
            [["01011"],  3, 'example 3'],
            [["010101"], 3, 'example 4'],
            [["00001"],  4, 'example 5'],
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
