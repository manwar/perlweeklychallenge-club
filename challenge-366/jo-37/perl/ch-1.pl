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

usage() unless @ARGV > 1;

sub usage {
    die <<~EOS;
    $0 - count prefixes

    usage: $0 [-examples] [-tests] [-verbose] [STR WORD...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        print prefixes instead of counting them

    STR
        a string
    WORD
        list of words

    EOS
}


### Input and Output

say $verbose ? "@{[count_prefixes(@ARGV)]}" : scalar count_prefixes(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/27/ch-366.html#task-1

sub count_prefixes ($str, @arr) {
    grep !index($str, $_), @arr;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = count_prefixes(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[apple => "a", "ap", "app", "apple", "banana"], 4, 'example 1'],
            [[bird => "cat", "dog", "fish"], 0, 'example 2'],
            [[hello => "hello", "he", "hell", "heaven", "he"], 4, 'example 3'],
            [[coding => "", "code", "coding", "cod"], 3, 'example 4'],
            [[program => "p", "pr", "pro", "prog", "progr", "progra",
                    "program"], 7, 'example 5'],
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
