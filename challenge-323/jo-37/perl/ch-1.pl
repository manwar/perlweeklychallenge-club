#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util qw(reduce sum0);


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
    $0 - increment decrement

    usage: $0 [-examples] [-tests] [-- op...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    op...
        operations consisting of 'x++', '++x', 'x--' or '--x'

    EOS
}


### Input and Output

say inc_dec(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/30/ch-323.html#task-1


sub inc_dec {
    sum0 map /^(?=.{3}$)x?([-+])\1x?$/ && "${1}1", @_
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = inc_dec(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["--x", "x++", "x++"], 1, 'example 1'],
            [["x++", "++x", "x++"], 3, 'example 2'],
            [["x++", "++x", "--x", "x--"], 0, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 6;
        is inc_dec(qw(++y y++)), 0, 'invalid inc';
        is inc_dec(qw(--y y--)), 0, 'invalid dec';
        is inc_dec(qw(+x x+)), 0, 'invalid inc';
        is inc_dec(qw(-x x-)), 0, 'invalid dec';
        is inc_dec(qw(++x++x)), 0, 'two in one';
        is inc_dec(qw(+-x)), 0, 'mixed';
    }) : pass 'skip tests';

    exit;
}
