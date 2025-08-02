#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;

### Options and Arguments

my ($tests, $examples, $verbose, $len);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - Group digit sum

    usage: $0 [-examples] [-tests] [S I]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    S
        a number 

    I
        group length

    EOS
}


### Input and Output

say group_digit_sum(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/03/07/ch-311.html#task-2


sub group_digit_sum ($str, $len) {
    my $n = long split //, $str;
    $n = long map split(//, $_),
        $n->reshape($len, ceil $n->dim(0) / $len)->sumover->list
        while $n->dim(0) > $len;
    join '', $n->list;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = group_digit_sum(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[111122333, 3], 359, 'example 1'],
            [[1222312, 2], 76, 'example 2'],
            [[100012121001, 4], 162, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is group_digit_sum(9999, 2), 99, 'carry';
        is group_digit_sum(999999999, 3), 36, 'multiple loops';
        is group_digit_sum('9' x 320, 40), '360' x 8, 'exceed longlong';
    }) : pass 'skip tests';

    exit;
}
