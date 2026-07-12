#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'minmax';


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
    $0 - smaller greater

    usage: $0 [-examples] [-tests] [-verbose] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        print the found numbers instead of their count

    N...
        list of numbers

    EOS
}


### Input and Output

main: {
    my @ret = smaller_greater(@ARGV);
    say $verbose ? "(@ret)" : scalar @ret;
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/07/10/ch-381.html#task-2

sub smaller_greater {
    my ($min, $max) = minmax @_;

    grep $_ != $min && $_ != $max, @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = smaller_greater(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[2, 4], 0, 'example 1'],
            [[1, 1, 1, 1], 0, 'example 2'],
            [[1, 1, 4, 8, 12, 12], 2, 'example 3'],
            [[3, 6, 6, 9], 2, 'example 4'],
            [[0, -5, 10, -2, 4], 3, 'example 5'],
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
