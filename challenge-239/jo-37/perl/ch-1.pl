#!/usr/bin/perl -s

use v5.25;
use Test2::V0;

our ($tests, $examples, $any);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [-any] [STR...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-any
    check if there are at least two strings that resolve to the same
    target string

STR...
    list of strings consisting of whitespace separated words

EOS


### Input and Output

say same_string($any, map [split /\s+/], @ARGV) ? 'true' : 'false';


### Implementation

# The task may easily extended to any number of arrays, though in more
# than one way.  Picking two edge cases:
# - all arrays resolve to the same string ("all").
# - there are at least two arrays that resolve to the same string
#   ("any").
sub same_string {
    # mode: true => any, false => all
    my $any = shift;
    my %strings;
    # Define keys for all distinct resolved strings:
    @strings{map join('', @$_), @_} = ();
    # Starting with v5.25 a hash in scalar context produces the number
    # of its keys.  This shall be less than the number of arrays in
    # "any" mode and less than 2 in "all" mode.
    %strings < ($any ? @_ : 2);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        ok  same_string(0, ['ab', 'c'], ['a', 'bc']), 'example 1';
        ok !same_string(0, ['ab', 'c'], ['ac', 'b']), 'example 2';
        ok  same_string(0, ['ab', 'cd', 'e'], ['abcde']), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok !same_string(0, [qw(a b c)], [qw(ab c)], [qw(ac b)]), '!all';
        ok  same_string(0, [qw(a b c)], [qw(ab c)], [qw(a bc)]), 'all';
        ok !same_string(1, [qw(a b c)], [qw(a cb)], [qw(ba c)]), '!any';
        ok  same_string(1, [qw(a b c)], [qw(ab c)], [qw(ac b)]), 'any';
	}

    done_testing;
    exit;
}
