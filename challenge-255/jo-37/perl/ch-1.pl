#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [S T]

-examples
    run the examples from the challenge
 
-tests
    run some tests

S T
    two strings

EOS


### Input and Output

say "@{[char_diff(@ARGV)]}";


### Implementation

sub char_diff ($s, $t) {
    my %count;
    $count{$_}++ for split //, $t;
    $count{$_}-- for split //, $s;
    no warnings 'numeric';
    map +($_) x $count{$_}, keys %count;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [char_diff('Perl', 'Preel')], ['e'], 'example 1';
        is [char_diff('Weekly', 'Weeakly')], ['a'], 'example 2';
        is [char_diff('Box', 'Boxy')], ['y'], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [char_diff('abcde', 'ddd')], ['d', 'd'], 'more than one';
	}

    done_testing;
    exit;
}
