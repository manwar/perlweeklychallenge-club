#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Roman;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 3;
usage: $0 [-examples] [-tests] [-verbose] [X OP Y]

-examples
    run the examples from the challenge
 
-tests
    run some tests

X Y
    Roman numerals

OP
    operation to apply to the given numbers, one of +, -, *, / or **.

EOS


### Input and Output

say r_calc(@ARGV);


### Implementation

# Convert Roman numerals to Arabic, perform the requested operation and
# convert back to Roman.

sub r_calc ($x, $op, $y) {
    my $ax = arabic($x);
    my $ay = arabic($y);
    die "not a Roman numeral\n" unless $ax && $ay;
    for ($op) {
        /^\+$/ && return Roman($ax + $ay) // 'non potest';
        /^-$/ && return $ax == $ay ? 'nulla' : Roman($ax - $ay) // 'non potest';
        /^\*$/ && return Roman($ax * $ay) // 'non potest';
        /^\*\*$/ && return Roman($ax ** $ay) // 'non potest';
        m{^/$} && return $ay * int($ax / $ay) == $ax ?
            Roman($ax / $ay) : 'non potest';
    }
    undef;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is r_calc(qw(IV + V)), 'IX', 'example 1';
        is r_calc(qw(M - I)), 'CMXCIX', 'example 2';
        is r_calc(qw(X / II)), 'V', 'example 3';
        is r_calc(qw(XI * VI)), 'LXVI', 'example 4';
        is r_calc(qw(VII ** III)), 'CCCXLIII', 'example 5';
        is r_calc(qw(V - V)), 'nulla', 'example 6';
        is r_calc(qw(V / II)), 'non potest', 'example 7';
        is r_calc(qw(MMM + M)), 'non potest', 'example 8';
        is r_calc(qw(V - X)), 'non potest', 'example 9';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
