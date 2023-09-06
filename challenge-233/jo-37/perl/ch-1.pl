#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util qw(uniq reduce);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

WORD...
    list of words

EOS


### Input and Output
say similar_words(@ARGV);


### Implementation

# Count the words having unique sorted characters.  In every group, all
# the words are pairwise similar.  Calculate the number of pairs in
# every group and sum these.
sub similar_words {
    my %similar;
    $similar{join '', uniq sort split //}++ for @_;
    reduce {$a + $b * ($b - 1) / 2} 0, values %similar;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is similar_words("aba", "aabb", "abcd", "bac", "aabc"), 2, 'example 1';
        is similar_words("aabb", "ab", "ba"), 3, 'example 2';
        is similar_words("nba", "cba", "dba"), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
