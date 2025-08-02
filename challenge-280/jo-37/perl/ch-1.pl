#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    a string

EOS


### Input and Output

say twice_appearance(shift) // '';


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/02/ch-280.html#task-1


sub twice_appearance {
    shift =~ /
                (.)                 # a single char
                (?=(.*))            # capture rest of string
                (
                    \1.+\2          # stop if current char precedes itself
                    |               # or
                    (?<=            # look behind:
                        (?=         # look ahead:
                            (?3)    # recursion: stop or look behind
                        )
                        .           # one char
                    )
                )
            /x;
    $1;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is twice_appearance("acbddbca"), "d", "example 1";
        is twice_appearance("abccd"), "c", "example 2";
        is twice_appearance("abcdabbb"), "a", "example 3";
    }

    SKIP: {
        skip "tests" unless $tests;

        is twice_appearance("abcde"), U(), "nothing twice";
	}

    done_testing;
    exit;
}
