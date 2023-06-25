#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say last_member(@ARGV);


### Implementation

sub last_member {
    # Break recursion.
    return $_[0] // 0 if @_ < 2;
    # Get the largest two elements and the remainder.
    (my ($y, $x), @_) = sort {$b <=> $a} @_;
    # Append a non-zero difference.
    push @_, $y - $x if $y > $x;
    # Replace the subroutine call with itself: recursion without stack
    # growth.
    goto &last_member;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is last_member(2, 7, 4, 1, 8, 1), 1, 'example 1';
        is last_member(1), 1, 'example 2'; 
        is last_member(1, 1), 0, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is last_member(1, 3, 6), 2, 'non-zero';
	}

    done_testing;
    exit;
}
