#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [REGNO WORD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

REGNO
    a registration number

WORD...
    list of words

EOS


### Input and Output

say "@{[filter_words(@ARGV)]}";


### Implementation

sub filter_words {
	my $reg = shift;
    # Extract all letters from the registration number and transform
    # them into positive lookahead assertions.
    my $letters = join '', map "(?=.*?$_)", $reg =~ m/[[:alpha:]]/g;

    # Filter the words for those containing all letters from the
    # registration number.
    grep /^$letters/i, @_
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [filter_words('AB1 2CD', 'abc', 'abcd', 'bcd')], ['abcd'],
            'example 1';

        is [filter_words('007 JB', 'job', 'james', 'bjorg')],
            ['job', 'bjorg'], 'example 2';

        is [filter_words('C7 RA2', 'crack', 'road', 'rac')],
            ['crack', 'rac'], 'example 3';

    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
