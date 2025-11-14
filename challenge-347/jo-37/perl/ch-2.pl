#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental 'signatures';

use List::Gather;

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
    $0 - format phone number

    usage: $0 [-examples] [-tests] [PHONE]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    PHONE
        a string containing a single phone number

    EOS
}


### Input and Output

say format_phone_number("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/11/14/ch-347.html#task-2

sub format_phone_number {
    join '-', gather {
        shift =~ tr/0-9//cdr =~
            /(?:(...)(?!.$)(?{take $+}))*(?:(..)(?{take $+}))*/;
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = format_phone_number(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["1-23-45-6"], "123-456", 'example 1'],
            [["1234"], "12-34", 'example 2'],
            [["12 345-6789"], "123-456-789", 'example 3'],
            [["123 4567"], "123-45-67", 'example 4'],
            [["123 456-78"], "123-456-78", 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["1234567890"], "123-456-78-90", 'multiple matches'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
