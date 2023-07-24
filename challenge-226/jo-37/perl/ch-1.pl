#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && length($ARGV[0]) == @ARGV - 1;
usage: $0 [-examples] [-tests] [STR N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    a string

N...
    list of numbers. The number of elements must match the length of the
    string.  The order of the numbers defines the order of the
    characters picked from the string.

EOS


### Input and Output

say shuffle_string(@ARGV);


### Implementation

# Calling the given numbers "indices" and providing values that could be
# used as indices in the examples is probably a red herring.  What we
# have here is a list of numbers in the length of the string but no
# further restrictions.  We need to follow the numbers in ascending
# order and pick the respective character from the same position.
# Performing an index sort on the numbers and take the result as an
# array slice from the split string that is joined afterwards.
sub shuffle_string {
    my $s = shift;
    join '', (split //, $s)[sort {$_[$a] <=> $_[$b]} 0 .. $#_];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is shuffle_string('lacelengh', 3,2,0,5,4,8,6,7,1),
            'challenge', 'example 1';
        is shuffle_string('rulepark', 4,7,3,1,0,5,2,6),
            'perlraku', 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is shuffle_string('rayadverb', 13, 3, 17, 11, 1, 5, 7, 15, 9),
            'davebarry', 'non-indices';
        is shuffle_string('baab', 2, 1, 1, 2), 'aabb', 'non-unique';
	}

    done_testing;
    exit;
}
