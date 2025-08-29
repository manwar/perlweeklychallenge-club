#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'frequency';
use List::Util 'pairmap';
use Math::Prime::Util 'gcd';


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
    $0 - equal group

    usage: $0 [-examples] [-tests] [I...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    I...
        list of items

    EOS
}


### Input and Output

say +(qw(TRUE FALSE))[!equal_group(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/29/ch-336.html#task-1

sub equal_group {
    1 < gcd pairmap {$b} frequency @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = equal_group(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1,1,2,2,2,2], T(), 'example 1'],
            [[1,1,1,2,2,2,3,3], F(), 'example 2'],
            [[5,5,5,5,5,5,7,7,7,7,7,7], T(), 'example 3'],
            [[1,2,3,4], F(), 'example 4'],
            [[8,8,9,9,10,10,11,11], T(), 'example 5'],
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
