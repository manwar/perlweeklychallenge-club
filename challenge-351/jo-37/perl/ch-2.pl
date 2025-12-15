#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;
use PDL::LinearAlgebra;

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV > 2;

sub usage {
    die <<~EOS;
    $0 - arithmetic progression

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

say +(qw(true false))[!arith_progression(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/12/12/ch-351.html#task-2

sub arith_progression {
    my $n = pdl(\@_, [0]);
    $n($n(,(0))->qsorti,1) .= sequence($n->dim(0));
    1 == mrank $n(1:-1) - $n(0), 1e-14;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = arith_progression(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 3, 5, 7, 9], T(), 'example 1'],
            [[9, 1, 7, 5, 3], T(), 'example 2'],
            [[1, 2, 4, 8, 16], F(), 'example 3'],
            [[5, -1, 3, 1, -3], T(), 'example 4'],
            [[1.5, 3, 0, 4.5, 6], T(), 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        arith_progression(1.5, 3, 4.5, 6);
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
