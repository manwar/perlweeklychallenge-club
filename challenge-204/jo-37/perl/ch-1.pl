#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [--] [N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 N2...
    List of numbers

EOS


### Input and Output

say 0 + is_monotonic(@ARGV); 


### Implementation

# Comparing consecutive elements from the list yields values in the set
# {-1, 0, 1}, where a non-monotonic list has both -1 and 1 in the result
# set.  Summating over the absolute values of the unique results from
# the comparisons thus reveals the monotonic property: The sum will be
# two for a non-monotonic list. 
sub is_monotonic {
	my $list = pdl @_;

    ($list(1:-1) <=> $list(0:-2))->uniq->abs->sum < 2;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  is_monotonic(1, 2, 2, 3), 'example 1';
        ok !is_monotonic(1, 3, 2),    'example 2';
        ok  is_monotonic(6, 5, 5, 4), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
