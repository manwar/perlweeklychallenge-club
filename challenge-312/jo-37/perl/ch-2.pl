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
    $0 - balls and boxes

    usage: $0 [-examples] [-tests] [BALLS]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    BALLS
        a string of alternating color ('R', 'G', 'B') and box number

    EOS
}


### Input and Output

say balls_and_boxes(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/03/14/ch-312.html#task-2

BEGIN {
    our %colors = (R => 0, G => 1, B => 2);

    sub balls_and_boxes {
        my $balls = long(
            map s/([RGB])/$colors{$_}/r,
            split /(?<!\d)(?=\d)|(?<=\d)(?!\d)/, shift
        )->splitdim(0, 2);
        my $boxes = zeroes 3, 1 + max $balls(1);
        $boxes->indexND($balls) .= 1;
        $boxes->andover->sum;
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = balls_and_boxes(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["G0B1R2R0B0"], 1, 'example 1'],
            [["G1R3R6B3G6B1B6R1G3"], 3, 'example 2'],
            [["B3B2G1B3"], 0, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is balls_and_boxes(
            "B12B11G12R12G11R10"
        ), 1, 'boxes 10, 11 and 12';
    }) : pass 'skip tests';

    exit;
}
