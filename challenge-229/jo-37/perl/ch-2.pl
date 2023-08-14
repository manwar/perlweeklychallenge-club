#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::MoreUtils 'apply';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [--] [LIST1 LIST2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

LIST1 LIST2...
    some comma separated lists of numbers

EOS


### Input and Output

say "(@{more_than_once(map [split /,\s*/, $_], @ARGV)})";


### Implementation

# This task may be extended to any number of given arrays without any
# extra effort.
# The result is presented in random order as there is no special
# requirement in the task's description.
sub more_than_once {
    my %count;
    # Increment the values of a hash slice.  Unlike "map", "apply" does
    # not modify the elements of the input list.  So we can increment
    # "undef" to one and do not increment any value more than once.
    @count{@$_} = apply {++$_} @count{@$_} for @_;
    [grep $count{$_} > 1, keys %count];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        like more_than_once([1, 1, 2, 4], [2, 4], [4]), 
            bag {item 2; item 4; end;}, 'example 1';
        like more_than_once([4, 1], [2, 4], [1, 2]),
            bag {item 1; item 2; item 4; end;}, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
