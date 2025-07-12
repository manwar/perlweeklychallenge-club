#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Set::Scalar;
use List::UtilsBy 'max_by';

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
    $0 - nice string

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

say nice_string(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/07/11/ch-329.html#task-2

sub split_nice ($str) {
    my $nice = Set::Scalar->new($str =~ /\p{Ll}/g) *
        Set::Scalar->new(map lc, $str =~ /\p{Lu}/g);
    return () if $nice->is_null;
    my @parts = grep $_, split qr{[^ @$nice]+}ixx, $str;
    @parts == 1 ? @parts : map split_nice($_), @parts;
}

sub nice_string ($str) {
    (max_by {length} split_nice($str)) // '';
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = nice_string(@$args);
        is $result, $expected,
            qq{$name: "@$args" -> "$expected"};
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["YaaAho"], "aaA", 'example 1'],
            [["cC"], "cC", 'example 2'],
            [["A"], "", 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["abdAcAaAcBbdcabD"], "AaA", 'recurse substrings'],
            [["aA1BBb"], "BBb", 'non-letter'],
            [["abcDd"], "Dd", 'non-nice head'],
            [["Ddefg"], "Dd", 'non-nice tail'],
            [["AacbB"], "Aa", 'non-unique substring'],
            [["abAcBab"], "", 'segmented'],
            [["aA Bb"], "aA", 'blank'],
            [["äÄÖöüÜßSs"], "äÄÖöüÜ", 'umlauts'],
            [["aAxaAbBxaAbBcCxaAbBcCdD"], "aAbBcCdD", 'multiple substrings'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
