#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use List::Util 'zip';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 3;

sub usage {
    die <<~EOS;
    $0 - validate coupon

    usage: $0 [-examples] [-tests] [-verbose] [CODES NAMES STATUS]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    CODES
        list of codes

    NAMES
        list of category names

    STATUS
        list of status

    EOS
}


### Input and Output

say "(@{[(qw(false true))[validate_coupon(map [split /\s+/, $_], @ARGV)]]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/12/26/ch-353.html#task-2


sub validate_coupon {
    (\my %cat)->@{qw(electronics grocery pharmacy restaurant)} = ();
    map {
        0 + ($_->[0] =~ /^\w+$/ && exists $cat{$_->[1]} && $_->[2] eq 'true')
    } zip @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [validate_coupon(@$args)];
        is $result, $expected,
            "$name: (@{[map qq('@$_'), @$args]}) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[["A123", "B_456", "C789", "D@1", "E123"],
                ["electronics", "restaurant", "electronics", "pharmacy",
                    "grocery"],
                ["true", "false", "true", "true", "true"]],
            [1, 0, 1, 0, 1], 'example 1'],
            [[["Z_9", "AB_12", "G01", "X99", "test"],
                ["pharmacy", "electronics", "grocery", "electronics",
                    "unknown"],
                ["true", "true", "false", "true", "true"]],
            [1, 1, 0, 1, 0], 'example 2'],
            [[["_123", "123", "", "Coupon_A", "Alpha"],
                ["restaurant", "electronics", "electronics", "pharmacy",
                    "grocery"],
                ["true", "true", "false", "true", "true"]],
            [1, 1, 0, 1, 1], 'example 3'],
            [[["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
                ["electronics", "electronics", "grocery", "grocery"],
                ["true", "true", "true", "true"]],
            [1, 1, 1, 1], 'example 4'],
            [[["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
                ["restaurant", "electronics", "grocery", "pharmacy",
                    "electronics"],
                ["true", "true", "true", "true", "false"]],
            [1, 1, 1, 1, 0], 'example 5'],
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
