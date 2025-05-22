#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;

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
    $0 - rank array

    usage: $0 [-examples] [-tests] [--] [I...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    I...
        list of integers

    EOS
}


### Input and Output

say rank_array(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/23/ch-322.html#task-2


sub rank_array {
    my $ints = long @_;
    my $si = $ints->qsorti;
    my $rank = zeroes($ints);
    $rank($si) .= $ints($si)->dummy(0)->enumvecg;
    $rank + 1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = rank_array(@$args)->unpdl;
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[55, 22, 44, 33], [4, 1, 3, 2], 'example 1'],
            [[10, 10, 10], [1, 1, 1], 'example 2'],
            [[5, 1, 1, 4, 3], [4, 1, 1, 3, 2], 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is rank_array(0, 11, 23, -10, -21)->unpdl, [3, 4, 5, 2, 1], 'negative';
    }) : pass 'skip tests';

    exit;
}
