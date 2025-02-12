#!/usr/bin/perl

use v5.26;
use Test2::V0  '!float';
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
use Getopt::Long;
use experimental 'signatures';
use utf8;

use PDL;
use PDL::Char;


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
    $0 - Find anagrams

    usage: $0 [-examples] [-tests] [W...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    W...
        list of words

    EOS
}


### Input and Output

say count_anagrams(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/02/07/ch-307.html#task-2

sub count_anagrams {
    1 + PDL::Char->new(map fc, @_)->qsort->enumvecg->at(-1);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = count_anagrams(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["acca", "dog", "god", "perl", "repl"], 3, 'example 1'],
            [["abba", "baba", "aabb", "ab", "ab"], 2, 'example 2'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is count_anagrams(qw(ab bc ba)), 3, 'non-adjacent';
        is count_anagrams(qw(Ruﬄe Flufre)), 1,
            'fold case, ligature ffl';
        is count_anagrams(qw(ab bc cd dc)), 3, 'last group';
    }) : pass 'skip tests';

    exit;
}
