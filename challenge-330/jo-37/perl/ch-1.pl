#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


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
    $0 - clear digits

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say clear_digits(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/07/18/ch-330.html#task-1

sub clear_digits ($str) {
    1 while $str =~ s/\P{N}?\p{N}//;
    $str;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = clear_digits(@$args);
        is $result, $expected,
            "$name: '@$args' -> '$expected'";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["cab12"], "c", 'example 1'],
            [["xy99"], "", 'example 2'],
            [["pa1erl"], "perl", 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["12ab3"], "a", 'leading digits'],
            [["ab¹c²d"], "ad", 'superscripts'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
