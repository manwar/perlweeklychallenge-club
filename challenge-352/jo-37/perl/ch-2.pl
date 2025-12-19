#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'reductions';


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
    $0 binary prefix

    usage: $0 [-examples] [-tests] [-verbose] [B...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    B...
        list of zeroes and ones

    EOS
}


### Input and Output

say join ' ', (qw(false true))[binary_prefix(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/12/19/ch-352.html#task-2

sub binary_prefix {
    map 0+!($_ % 5), reductions {2 * $a + $b} @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [binary_prefix(@$args)];
        is $result, $expected,
            "$name: (@$args) ->  (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[0,1,1,0,0,1,0,1,1,1],
               [1, 0, 0, 0, 0, 1, 1, 0, 0, 0], 'example 1'],
            [[1,0,1,0,1,0], [0, 0, 1, 1, 0, 0], 'example 2'],
            [[0,0,1,0,1], [1, 1, 0, 0, 1], 'example 3'],
            [[1,1,1,1,1], [0, 0, 0, 1, 0], 'example 4'],
            [[1,0,1,1,0,1,0,0,1,1], [0, 0, 1, 0, 0, 1, 1, 1, 0, 0], 'example 5'],
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
