#!/usr/bin/perl -s

use v5.24;
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
    list of non-negative integers

EOS


### Input and Output

say largest_number(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/03/ch-301.html#task-1


sub numcat {
    my $cmp = substr($b, 0, 1) <=> substr($a, 0, 1);
    return $cmp if $cmp;
    return 0 if length($a) == 1 && length($b) == 1;
    local $a = substr $a, 1 if length($a) > 1;
    local $b = substr $b, 1 if length($b) > 1;
    numcat();
}

sub largest_number {
    join '', sort numcat @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is largest_number(20, 3), 320, 'example 1';
        is largest_number(3, 30, 34, 5, 9), 9534330, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is largest_number(4, 45, 1, 6), 64541, 'pick longer';
        is largest_number(4, 44, 1, 6), 64441, 'pick any';
        is largest_number(4, 43, 1, 6), 64431, 'pick shorter';
        is largest_number(4, 445, 1, 6), 644541, 'pick longer #2';
        is largest_number(4, 444, 1, 6), 644441, 'pick any #2';
        is largest_number(4, 443, 1, 6), 644431, 'pick shorter #2';
    }

    done_testing;
    exit;
}
