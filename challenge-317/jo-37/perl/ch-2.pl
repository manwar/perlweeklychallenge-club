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

usage() unless @ARGV == 2;

sub usage {
die <<~EOS;
$0 - friendly strings

usage: $0 [-examples] [-tests] [STR1 STR2]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR1 STR2
    two strings

EOS
}


### Input and Output

say +(qw(true false))[!friendly(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/04/17/ch-317.html#task-2


sub friendly ($str1, $str2) {
    "$str1\n$str2" =~ /^(.*)(.)(.*)(.)(.*+)\n\1\4\3\2\5$/;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = friendly(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["desc", "dsec"], T(), 'example 1'],
            [["fuck", "fcuk"], T(), 'example 2'],
            [["poo", "eop"], F(), 'example 3'],
            [["stripe", "sprite"], T(), 'example 4'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 4;
        ok !friendly("abc", "ab"),    'different lengths';
        ok !friendly("abc", "abc"),   'not self-friendly';
        ok  friendly("abcb", "abcb"), 'self-friendly';
        ok !friendly("abc", "bca"),   'more than one swap';
    }) : pass 'skip tests';

    exit;
}
