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
    $0 - count prefix suffix

    usage: $0 [-examples] [-tests] [WORD...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    WORD...
        list of words

    EOS
}


### Input and Output

say count_prefix_suffix(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/06/12/ch-377.html#task-2

sub count_prefix_suffix {
    my @arr = sort {length($a) <=> length($b)} @_;
    my $count = 0;
    while (my $head = shift @arr) {
        $head = quotemeta $head;
        $count += /^(?=$head).*$head$/ for @arr;
    }

    $count;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = count_prefix_suffix(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["a", "aba", "ababa", "aa"], 4, 'example 1'],
            [["pa", "papa", "ma", "mama"], 2, 'example 2'],
            [["abao", "ab"], 0, 'example 3'],
            [["abab", "abab"], 1, 'example 4'],
            [["ab", "abab", "ababab"], 3, 'example 5'],
            [["abc", "def", "ghij"], 0, 'example 6'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is count_prefix_suffix('abab', 'ab'), 1, 'reverse order';
    }) : pass 'skip tests';

    exit;
}
