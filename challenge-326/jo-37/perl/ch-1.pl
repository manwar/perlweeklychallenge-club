#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use DateTime::Format::Strptime;

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
    $0 - day of the year

    usage: $0 [-examples] [-tests] [YYYY-MM-DD]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    YYYY-MM-DD
        a date

    EOS
}


### Input and Output

say day_of_year(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/06/18/ch-326.html#task-1

use constant YMD => DateTime::Format::Strptime->new(pattern => '%F',
    on_error => 'croak');

sub day_of_year {
    YMD->parse_datetime(shift)->day_of_year;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = day_of_year(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['2025-02-02'], 33, 'example 1'],
            [['2025-04-10'], 100, 'example 2'],
            [['2025-09-07'], 250, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        like dies {day_of_year('2024-02-30')},
            qr/did not produce a valid date/, 'invalid date';

    }) : pass 'skip tests';

    exit;
}
