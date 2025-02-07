#!/usr/bin/perl

use v5.26;
use Test2::V0 '!float';
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;

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
    $0 - Check order

    usage: $0 [-examples] [-tests] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of numbers

    EOS
}


### Input and Output

say "(@{check_order(@ARGV)->unpdl})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/02/07/ch-307.html#task-1


sub check_order {
    my $ints = long \@_;
    which $ints != $ints->qsort;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = check_order(@$args)->unpdl;
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[5, 2, 4, 3, 1], [0, 2, 3, 4], 'example 1'],
            [[1, 2, 1, 1, 3], [1, 3], 'example 2'],
            [[3, 1, 3, 2, 3], [0, 1, 3], 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is check_order(2, 3, 5, 7, 11)->unpdl, [], 'sorted';
        is check_order()->unpdl, [], 'empty';
        is check_order(42)->unpdl, [], 'singleton';
    }) : pass 'skip tests';

    exit;
}
