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
    $0 - minimum common

    usage: $0 [-examples] [-tests] [A...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    A...
        list of arrays of integers

    EOS
}


### Input and Output

say minimum_common(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/02/ch-319.html#task-2


sub minimum_common {
    my ($sect, @an) = map long($_), @_;
    $sect = setops $sect, 'AND', $_ for @an;
    $sect->isempty ? -1 : min $sect;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = minimum_common(@$args);
        is $result, $expected,
            "$name: (($args->[0]->@*), ($args->[1]->@*)) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[1, 2, 3, 4], [3, 4, 5, 6]], 3, 'example 1'],
            [[[1, 2, 3], [2, 4]], 2, 'example 2'],
            [[[1, 2, 3, 4], [5, 6, 7, 8]], -1, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        is minimum_common([1, 2, 3, 4], [2, 3, 4], [3, 4]), 3, 'three lists';
        is minimum_common([4, 3, 2]), 2, 'single list';
    }) : pass 'skip tests';

    exit;
}
