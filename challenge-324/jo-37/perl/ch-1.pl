#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
use Getopt::Long;
use experimental 'signatures';

use PDL;

### Options and Arguments

my ($tests, $examples, $verbose, $rows, $cols);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'rows=i'    => \$rows,
    'cols=i'    => \$cols,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless $rows && $cols && @ARGV;

sub usage {
    die <<~EOS;
    $0 - 2d array

    usage: $0 [-examples] [-tests] [-verbose] [-rows R -cols C N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -rows R
        number of rows

    -cols C
        number of columns

    N...
        list of numbers

    EOS
}


### Input and Output

say two_d_array($rows, $cols, @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/06/06/ch-324.html#task-1


sub two_d_array ($r, $c, @ints) {
    pdl(@ints)->reshape($c, $r);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = two_d_array(@$args);
        pdl_is $result, $expected,
            "$name: ($args->@[0, 1], ($args->@[2 .. $#$args])) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[2, 2, 1, 2, 3, 4], pdl([[1, 2], [3, 4]]), 'example 1'],
            [[1, 3, 1, 2, 3], pdl([[1, 2, 3]]), 'example 2'],
            [[4, 1, 1, 2, 3, 4], pdl([[1], [2], [3], [4]]), 'example 2'],
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
