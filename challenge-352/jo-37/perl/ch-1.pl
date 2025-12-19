#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental qw(signatures refaliasing);

use List::Util 'uniqstr';


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
    $0 - match string

    usage: $0 [-examples] [-tests] [STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR...
        list of strings

    EOS
}


### Input and Output

say "(@{[match_string(@ARGV)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/12/19/ch-352.html#task-1

sub match_string (@words) {
    uniqstr grep {
        \my $word = \$_;
        1 < grep {
            0 <= index($_, $word)
        } @words
    } @words;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [match_string(@$args)];
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["cat", "cats", "dog", "dogcat", "dogcat", "rat",
                    "ratcatdogcat"],
                ["cat", "dog", "dogcat", "rat"], 'example 1'],
            [["hello", "hell", "world", "wor", "ellow", "elloworld"],
                ["hell", "world", "wor", "ellow"], 'example 2'],
            [["a", "aa", "aaa", "aaaa"],
                ["a", "aa", "aaa"], 'example 3'],
            [["flower", "flow", "flight", "fl", "fli", "ig", "ght"],
                ["flow", "fl", "fli", "ig", "ght"], 'example 4'],
            [["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"],
                ["car", "pet", "enter", "pen", "pent"], 'example 5'],
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
