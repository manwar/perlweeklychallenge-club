#!/usr/bin/perl

use v5.26;
use Test2::V0 '!float';
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
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
    $0 - Sort odd even

    usage: $0 [-examples] [-tests] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of numbers

    EOS
}


### Input and Output

say sort_odd_even(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/02/28/ch-310.html#task-2


sub sort_odd_even {
    my $ints = pdl \@_;
    $ints(0:-1:2)->inplace->qsort;
    $ints(1:-1:2)->(-1:0)->inplace->qsort;
    $ints;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = sort_odd_even(@$args);
        my $exp = pdl $expected;
        pdl_is $result, $exp,
            "$name: (@$args) -> $exp";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[4, 1, 2, 3], [2, 3, 4, 1], 'example 1'],
            [[3, 1], [3, 1], 'example 2'],
            [[5, 3, 2, 1, 4], [2, 3, 4, 1, 5], 'example 3'],
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
