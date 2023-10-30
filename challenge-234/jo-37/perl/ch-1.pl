#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Gather;
use warnings FATAL => 'all';
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR...
    list of strings

EOS


### Input and Output

say qq{(@{[join ', ', map qq{"$_"}, common_chars(@ARGV)]})};


### Implementation

# Split the first string into its characters and try to remove the first
# occurrence of each character in every remaining string.  If the
# character was removed as many times as there are remaining words, it
# was part of all words.  Gather these.  Quoting the characters allows
# regex meta-characters within the given strings.

sub common_chars (@w) {
    gather for my $c (split //, shift @w) {
        take $c if @w == grep s/\Q$c//, @w;
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [common_chars("java", "javascript", "julia")],
            ["j", "a"], 'example 1';

        is [common_chars("bella", "label", "roller")],
            ["e", "l", "l"], 'example 2';

        is [common_chars("cool", "lock", "cook")],
            ["c", "o"], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [common_chars(qw(abc bcd cde efg))], [], 'no common chars';
        is [common_chars("afedcbaf")], [qw(a f e d c b a f)], 'single word';
        is [common_chars(qw(a. [ab] a*))], ['a'], 'regex meta chars';
	}

    done_testing;
    exit;
}
