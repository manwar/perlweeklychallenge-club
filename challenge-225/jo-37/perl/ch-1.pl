#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'max';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [SENTENCE...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SENTENCE...
    list of sentences

EOS


### Input and Output

say max_words(@ARGV);


### Implementation

# From the definition of a sentence as "a list of words separated by
# single spaces without leading or trailing spaces" the number of words
# can easily derived as one more than the number of spaces.
sub max_words {
	1 + max map {(my $s = $_) =~ tr/ //d} @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is max_words("Perl and Raku belong to the same family.",
                "I love Perl.",
                "The Perl and Raku Conference."), 8, 'example 1';
        is max_words("The Weekly Challenge.",
                "Python is the most popular guest language.",
                "Team PWC has over 300 members."), 7, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
