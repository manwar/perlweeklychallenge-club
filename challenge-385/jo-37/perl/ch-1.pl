#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'singleton';


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
    $0 - uncommon words

    usage: $0 [-examples] [-tests] [STR1 STR2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR1 STR2
        two strings of space separated words

    EOS
}


### Input and Output

say "(@{[uncommon_words(@ARGV)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/08/07/ch-385.html#task-1

sub uncommon_words {
    singleton map split, @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = uncommon_words(@$args);
        is \@result, $expected,
            qq{$name: (@{[map qq{"$_"}, @$args]}) -> } . 
            join ' ', map qq{"$_->{expect}"}, $expected->items->@*;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["apple banana apple", "banana orange"],
                bag {item "orange"; end},
                'example 1'],
            [["cat dog", "bird fish"],
                bag {item "cat"; item "dog"; item "bird"; item "fish"; end},
                'example 2'],
            [["the quick brown fox", "the quick"],
                bag {item "brown"; item "fox"; end},
                'example 3'],
            [["hello", "hello"], bag {end}, 'example 4'],
            [["blue blue red", "red green green yellow"],
                bag {item "yellow"; end}, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["a a b b c", "b c d"],
                bag {item "d"; end},
                'several variations'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
