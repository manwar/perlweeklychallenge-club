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
    $0 - last visitor

    usage: $0 [-examples] [-tests] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of integers

    EOS
}


### Input and Output

say last_visitor(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/31/ch-345.html#task-2

sub last_visitor {
    my $ints = long @_;
    my $p    = $ints >= 0;
    my $seen = append $ints(-1:0)->where_both($p(-1:0));
    my $len  = $p->cumusumover;

    $seen($p(*1)->enumvec + $len(-1) - $len)->(!$p;?);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $result = last_visitor(@$args)->unpdl;
        my $todo;
        $todo = todo $reason if $reason;
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[5, -1, -1], [5, -1], 'example 1'],
            [[3, 7, -1, -1, -1], [7, 3, -1], 'example 2'],
            [[2, -1, 4, -1, -1], [2, 4, 2], 'example 3'],
            [[10, 20, -1, 30, -1, -1], [20, 30, 20], 'example 4'],
            [[-1, -1, 5, -1], [-1, -1, 5], 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[-1, -1, -1], [-1, -1, -1], 'all -1'],
            [[1, 2, 3], [], 'no -1'],
            [[1, 0, 3, -1, -1], [3, 0], 'allow zero'],
            [[1, 0, 3, -2, -3, -4, -5], [3, 0, 1, -5],
                'allow other negative numbers'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
