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
    $0 - final price

    usage: $0 [-examples] [-tests] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of numbers

    EOS
}


### Input and Output

say final_price(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/06/13/ch-325.html#task-2


sub final_price {
    my $price = pdl @_;
    $price - (
        (($price <= $price->dummy(0)) &
            (sequence($price) > sequence($price)->dummy(0))) * $price
    )->firstnonzeroover;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = final_price(@$args)->unpdl;
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[8, 4, 6, 2, 3], [4, 2, 4, 2, 3], 'example 1'],
            [[1, 2, 3, 4, 5], [1, 2, 3, 4, 5], 'example 2'],
            [[7, 1, 1, 5], [6, 0, 1, 5], 'example 3'],
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
