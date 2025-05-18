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
    $0 - distinct averages

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

say distinct_avg(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/18/ch-321.html#task-1

use constant SCALE => 1e8;

sub distinct_avg {
    my $n = pdl(@_)->qsort->splitdim(0, 2);
    $n(1) .= $n(1,-1:0;|);
    ($n->sumover * SCALE)->rint->uniq->nelem;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = distinct_avg(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 2, 4, 3, 5, 6], 1, 'example 1'],
            [[0, 2, 4, 8, 3, 5], 2, 'example 2'],
            [[7, 3, 1, 0, 5, 9], 2, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is distinct_avg(-1.3, -.3, .7, 1.7), 1, 'floating point input';
    }) : pass 'skip tests';

    exit;
}
