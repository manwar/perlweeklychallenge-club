#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::Char;

our ($tests, $examples, $char);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless defined $char && @ARGV == 1;
usage: $0 [-examples] [-tests] [-char=C S]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-char=C
    find distances to character C within the given string S

S
    a string

EOS


### Input and Output

say shortest_distance($char, shift);


### Implementation

sub shortest_distance {
    my $c = PDL::Char->new(shift);
    my $s = PDL::Char->new(shift);
    my $p = which($s == $c)->long;
    return if $p->isempty;

	minover abs sequence(1, $s->dim(0)) - $p;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is shortest_distance('e', 'loveleetcode')->unpdl,
            [3,2,1,0,1,0,0,1,2,2,1,0], 'example 1';
        is shortest_distance('b', 'aaab')->unpdl,
            [3,2,1,0], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
