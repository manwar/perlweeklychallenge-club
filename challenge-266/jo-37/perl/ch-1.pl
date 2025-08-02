#!/usr/bin/perl -s


use v5.24;
use Test2::V0;
use List::MoreUtils 'singleton';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [SENTENCE...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SENTENCE
    a list of sentences

EOS


### Input and Output

say "('", join("', '", uncommon_words(@ARGV)), "')";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/04/26/ch-266.html#task-1


sub uncommon_words {
    singleton map /[[:alpha:]]+/g, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [uncommon_words('Mango is sweet', 'Mango is sour')],
            ['sweet', 'sour'], 'example 1';

        is [uncommon_words('Mango Mango', 'Orange')],
            ['Orange'], 'example 2';

        is [uncommon_words('Mango is Mango', 'Orange is Orange')],
            [], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [uncommon_words('Twenty-two two-headed beasts headed east.')],
            [qw(Twenty beasts east)], 'ignore non-alpha';
	}

    done_testing;
    exit;
}
