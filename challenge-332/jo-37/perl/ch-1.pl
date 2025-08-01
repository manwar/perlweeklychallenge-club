#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Date::Manip::Date;


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
    $0 - binary date

    usage: $0 [-examples] [-tests] [DATE]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    DATE
        a date in any format parsable by Date::Manip::Date::parse_date,
        e.g. YYYYMMDD, YYMMDD, YYYY-MM-DD etc.

    EOS
}


### Input and Output

say binary_date("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/01/ch-332.html#task-1


sub binary_date {
    my $date = Date::Manip::Date->new;
    $date->parse_date(shift) && die $date->err;
    sprintf "%b-%b-%b", $date->printf(qw(%Y %f %e));
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = binary_date(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["2025-07-26"], "11111101001-111-11010", 'example 1'],
            [["2000-02-02"], "11111010000-10-10", 'example 2'],
            [["2024-12-31"], "11111101000-1100-11111", 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        like dies{binary_date("2025-02-29")}, qr/Invalid date/, 'invalid date';
        is binary_date("250729"), "11111101001-111-11101", 'different format';
    }) : pass 'skip tests';

    exit;
}
