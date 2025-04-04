#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'indexes';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV > 1;

sub usage {
    die <<~EOS;
    $0 - find words

    usage: $0 [-examples] [-tests] [CHR WORD...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    CHR
        a character (or string)

    WORD...
        list of words

    EOS
}


### Input and Output

say "@{[find_words(@ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/04/04/ch-315.html#task-1


sub find_words {
    my $c = shift;
    indexes {/\Q$c\E/} @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = [find_words(@$args)];
        my $c = shift @$args;
        is $result, $expected,
            "$name: ($c => @$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["e", "the", "weekly", "challenge"], [0, 1, 2], 'example 1'],
            [["p", "perl", "raku", "python"], [0, 2], 'example 2'],
            [["b", "abc", "def", "bbb", "bcd"], [0, 2, 3], 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is [find_words("." => "a.b", "cde")], [0], 'use regex meta char';
    }) : pass 'skip tests';

    exit;
}
