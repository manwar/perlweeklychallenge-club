#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use DateTime::Format::Strptime;
use DateTime::Format::DateParse;

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
    $0 - format date

    usage: $0 [-examples] [-tests] [DATE]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    DATE
        a date parseable by Date::Parse

    EOS
}


### Input and Output

say format_date("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/11/14/ch-347.html#task-1

sub format_date {
    state $fmt = DateTime::Format::Strptime->new(pattern => '%F');
    DateTime::Format::DateParse->parse_datetime(shift)->set_formatter($fmt);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = format_date(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["1st Jan 2025"],  string("2025-01-01"), 'example 1'],
            [["22nd Feb 2025"], string("2025-02-22"), 'example 2'],
            [["15th Apr 2025"], string("2025-04-15"), 'example 3'],
            [["23rd Oct 2025"], string("2025-10-23"), 'example 4'],
            [["31st Dec 2025"], string("2025-12-31"), 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        like dies {format_date("29th Feb 2025")}, qr/invalid/i, 'invalid date';
    }) : pass 'skip tests';

    exit;
}
