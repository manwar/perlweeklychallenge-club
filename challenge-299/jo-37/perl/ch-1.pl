#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [SENTENCE WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SENTENCE
    a sentence

WORD...
    words to be replaced

EOS


### Input and Output

say replace_words(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/12/13/ch-299.html#task-1


sub replace_words {
    my $sentence = shift;
    my $words = join '|', map quotemeta, @_;

    $sentence =~ s/(?<!\w)(?:$words)\K\w*//gr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is replace_words("the cattle was rattle by the battery",
            "cat", "bat", "rat"),
            "the cat was rat by the bat", "example 1";

        is replace_words("aab aac and cac bab", "a", "b", "c"),
            "a a a c b", "example 2";

        is replace_words("the manager was hit by a biker", "man", "bike"),
            "the man was hit by a bike", "example 3";
    }

    SKIP: {
        skip "tests" unless $tests;
        
        is replace_words("abbc bbcd", "bbc"), "abbc bbc", "test 1";
        is replace_words("xyz abbc bbcd", "bbc"), "xyz abbc bbc", "test 2";
        is replace_words("xyz abbc bbc", "bbc"), "xyz abbc bbc", "test 3";
    }

    done_testing;
    exit;
}
