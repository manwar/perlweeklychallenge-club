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
    $0 - maximum consecutive

    usage: $0 [-examples] [-tests] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of integers

    EOS
}


### Input and Output

say max_consec(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/06/13/ch-325.html#task-1


sub max_consec {
    my ($count, $val) = long(@_)->rle;
    $count->where($val)->max->setbadtoval(0);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = max_consec(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[0, 1, 1, 0, 1, 1, 1], 3, 'example 1'],
            [[0, 0, 0, 0], 0, 'example 2'],
            [[1, 0, 1, 0, 1, 1], 2, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is max_consec(0, 0, 0, 0, 1, 2, 2, 3, 3, 3), 3, 'non-binary';
    }) : pass 'skip tests';

    exit;
}
