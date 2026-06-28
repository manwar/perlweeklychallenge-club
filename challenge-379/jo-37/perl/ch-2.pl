#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(todigits vecsum);


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - Armstrong numbers

    usage: $0 [-examples] [-tests] [BASE LIMIT]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    BASE
        base for armstrong numbers

    LIMIT
        limit for armstrong numbers

    EOS
}


### Input and Output

say "@{[armstrong(@ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/06/28/ch-379.html#task-2

sub armstrong ($base, $limit) {
    my sub dps {
        my @digits = todigits shift, $base;
        vecsum map $_ ** @digits, @digits;
    }

    grep $_ == dps($_), 0 .. $limit;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = armstrong(@$args);
        is \@result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[10, 1000],
                [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407],
                'example 1'],
            [[7, 1000],
                [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250],
                'example 2'],
            [[16, 1000],
                [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342,
                    371, 520, 584, 645],
                'example 2'],
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
