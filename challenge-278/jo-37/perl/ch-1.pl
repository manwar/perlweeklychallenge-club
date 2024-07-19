#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [SHUFFLED_WORDS]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SHUFFLED_WORDS
    string or list of shuffled words

EOS


### Input and Output

say sort_string("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/07/19/ch-278.html#task-1


sub sort_string {
    join " ",
    map $_->[0],
    sort {$a->[1] <=> $b->[1]}
    map [/(.+?)(\d+)$/],
    split /\s+/, shift;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is sort_string("and2 Raku3 cousins5 Perl1 are4"),
        "Perl and Raku are cousins", "example 1";

        is sort_string("guest6 Python1 most4 the3 popular5 is2 language7"),
        "Python is the most popular guest language", "example 2";

        is sort_string("Challenge3 The1 Weekly2"),
        "The Weekly Challenge", "example 3";
    }

    SKIP: {
        skip "tests" unless $tests;

        is sort_string("twelve12 one1 two2 eight8 six6 seven7 five5 ten10 four4 eleven11 nine9 three3"),
        "one two three four five six seven eight nine ten eleven twelve",
        "more than ten";
	}

    done_testing;
    exit;
}
