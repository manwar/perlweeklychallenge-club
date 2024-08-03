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

say count_asterisks(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/08/02/ch-280.html#task-2


sub count_asterisks {
    shift =~ s/\|[^|]*\|//rg =~ tr/*//;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is count_asterisks("p|*e*rl|w**e|*ekly|"), 2, "example 1";
        is count_asterisks("perl"), 0, "example 2";
        is count_asterisks("th|ewe|e**|k|l***ych|alleng|e"), 5, "example 3";
    }

    SKIP: {
        skip "tests" unless $tests;

        is count_asterisks("*|**|****"), 5, "bar pair";
        is count_asterisks("*|**|****|"), 5, "trailing bar";
        is count_asterisks("|*|**|****"), 6, "leading bar";
        is count_asterisks("|*|**|****|"), 2, "leading and trailing bar";
        is count_asterisks("*||**|"), 3, "empty part";
	}

    done_testing;
    exit;
}
