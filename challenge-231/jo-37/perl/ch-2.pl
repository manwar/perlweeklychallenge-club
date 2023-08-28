#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [PD...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print passenger details for senior citizens instead of their count

PD...
    list of passenger details

EOS


### Input and Output

if ($verbose) {
    say for seniors(@ARGV);
} else {
    say scalar seniors(@ARGV);
}


### Implementation

# When assuming telephone numbers of variable length and a non-binary
# sex, the first part might have variable length and the sex is any
# uppercase character. These are to be followed by a 2-digit age and
# seat number.  Afterwards we skip all items where the age is below 60.
# In scalar context this gives the number of senior citizens.
sub seniors {
	grep /^ \d+ [[:upper:]] (\d{2}) \d{2} $ (?(?{$1 < 60})(*FAIL))/x, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [seniors(qw(7868190130M7522 5303914400F9211 9273338290F4010))],
            [qw(7868190130M7522 5303914400F9211)], 'example 1';
        is [seniors(qw(1313579440F2036 2921522980M5644))],
            [], 'example 2';

    }

    SKIP: {
        skip "tests" unless $tests;

        is scalar(seniors('123X6001')), 1, 'short X';
	}

    done_testing;
    exit;
}
