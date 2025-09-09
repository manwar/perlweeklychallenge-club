#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;

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
    $0 - highest row

    usage: $0 [-examples] [-tests] [-verbose] [--] [M]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    M
        a matrix in a form like 'a,b,c;d,e,f' or '[a b c] [d e f]'

    EOS
}


### Input and Output

say highest_row(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/09/12/ch-338.html#task-1


sub highest_row {
    max sumover pdl @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = highest_row(@$args);
        is $result, $expected,
            "$name: (@{[map qq([@$_]), @$args]}) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]],
                16, 'example 1'],
            [[[1, 5], [7, 3], [3, 5]], 10, 'example 2'],
            [[[1, 2, 3], [3, 2, 1]], 6, 'example 3'],
            [[[2, 8, 7], [7, 1, 3], [1, 9, 5]], 17, 'example 4'],
            [[[10, 20,  30], [5,  5,   5], [0,  100, 0], [25, 25,  25]],
                100, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
