#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental 'signatures';

use List::Util 'pairkeys';

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
    $0 - group position

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        enable trace output

    STR
        a string

    EOS
}


### Input and Output

say '"' . join('", "', group_position(shift)) . '"';


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/04/25/ch-318.html#task-1


sub group_position {
    shift =~ /((??{qr{(.)\1{2,}}}))/g;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = [group_position(@$args)];
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["abccccd"], ["cccc"], 'example 1'],
            [["aaabcddddeefff"], ["aaa", "dddd", "fff"], 'example 2'],
            [["abcdd"], [], 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
