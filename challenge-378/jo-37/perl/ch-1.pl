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
    $0 - second largest digit

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        an alphanumeric string

    EOS
}


### Input and Output

say second_largest(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/06/18/ch-378.html#task-1

sub second_largest {
    my @digits = shift =~ /\d/g;
    (\my @buckets)->@[@digits] = @digits;

    (grep defined, @buckets)[-2] // -1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = second_largest(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["aaaaa77777"], -1, 'example 1'],
            [["abcde"], -1, 'example 2'],
            [["9zero8eight7seven9"], 8, 'example 3'],
            [["xyz9876543210"], 8, 'example 4'],
            [["4abc4def2ghi8jkl2"], 4, 'example 5'],
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
