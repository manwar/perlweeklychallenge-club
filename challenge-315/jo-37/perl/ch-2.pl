#!/usr/bin/perl

use v5.30;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental qw(signatures vlb);


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
    $0 - find third

    usage: $0 [-examples] [-tests] [FIRST SECOND SENTENCE]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    FIRST
        first word

    SECOND
        second word

    SENTENCE
        a sentence

    EOS
}


### Input and Output

say "@{[find_third(@ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/04/04/ch-315.html#task-2

sub find_third ($first, $second, $sentence) {
    $sentence =~ /(?<=(?:^|\W)$first $second )(\w+)/g;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = [find_third(@$args)];
        my ($first, $second) = splice @$args, 0, 2;
        is $result, $expected,
            "$name: ($first, $second => @$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["my", "favourite" =>
            "Perl is a my favourite language but Python is my favourite too."],
                ["language", "too"], 'example 1'],
            [["a", "beautiful" =>
            "Barbie is a beautiful doll also also a beautiful princess."],
                ["doll", "princess"], 'example 2'],
            [["we", "will" => "we will we will rock you rock you."],
                ["we", "rock"], 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is [find_third("bc", "de" =>
            "bc de w1 abc de w2 a-bc de w3")],
             ["w1", "w3"], "match words only";
    }) : pass 'skip tests';

    exit;
}
