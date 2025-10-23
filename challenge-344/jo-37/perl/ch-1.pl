#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(fromdigits todigits);


### Options and Arguments

my ($tests, $examples, $verbose, $x);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'x=i'       => \$x,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV && defined $x;

sub usage {
    die <<~EOS;
    $0 - Task Title

    usage: $0 [-examples] [-tests] [-verbose] [--] [-x X N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -x
        an integer

    N...
        list of integers

    EOS
}


### Input and Output

say "(@{[array_form_comp($x, \@ARGV)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/23/ch-344.html#task-1

sub array_form_comp ($x, $ints) {
    todigits fromdigits($ints) + $x;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = [array_form_comp(@$args)];
        like $result, $expected,
            "$name: ($args->[1]->@*) + $args->[0] -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[12, [1, 2, 3, 4]], [1, 2, 4, 6], 'example 1'],
            [[181, [2, 7, 4]], [4, 5, 5], 'example 2'],
            [[1, [9, 9, 9]], [1, 0, 0, 0], 'example 3'],
            [[999, [1, 0, 0, 0]], [1, 9, 9, 9], 'example 4'],
            [[1000, [0]], [1, 0, 0, 0], 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[-1, [1, 0, 0]], [9, 9], 'minus'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
