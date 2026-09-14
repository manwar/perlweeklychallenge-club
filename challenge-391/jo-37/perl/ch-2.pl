#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::MatrixOps;


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
    $0 - arrange box

    usage: $0 [-examples] [-tests] [B...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    B...
        list of box sizes as string '[l1, w1], [l2, w2],...'

    EOS
}


### Input and Output

say arrange_box(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/04/ch-391.html#task-2

sub arrange_box {
    my $rect = long @_;
    my $adj = ($rect->dummy(1) < $rect)->andover;
    my $adjn = identity $adj;
    my $i = 0;
    $i++ while ($adjn x= $adj)->any;

    $i + 1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = arrange_box(@$args);
        is $result, $expected,
            qq{$name: (@{[map "[@$_]", @$args]}) -> $expected};
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[1, 3], [3, 5], [6, 8], [2, 4]], 4, 'example 1'],
            [[[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]], 3, 'example 2'],
            [[[5, 5], [5, 5], [5, 5]], 1, 'example 3'],
            [[[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]], 4, 'example 4'],
            [[[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]], 3,
                'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is arrange_box([2, 2, 2], [3, 3, 3], [4, 4, 4], [1, 2, 3]), 3,
            '3-d';
    }) : pass 'skip tests';

    exit;
}
