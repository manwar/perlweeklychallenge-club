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

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - convert palindrome

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

say convert_palindrome(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/04/ch-392.html#task-1

sub convert_palindrome ($str) {
    for my $l (reverse 1 .. length($str)) {
        return reverse(substr($str, $l)) . $str
            if substr($str, 0, $l) eq reverse substr($str, 0, $l);
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = convert_palindrome(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["pinnipeds"],  "sdepinnipeds",  'example 1'],
            [["abcd"],       "dcbabcd",       'example 2'],
            [["bananas"],    "sananabananas", 'example 3'],
            [["dissident"],  "tnedissident",  'example 4'],
            [["cailliachs"], "shcailliachs",  'example 5'],
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
