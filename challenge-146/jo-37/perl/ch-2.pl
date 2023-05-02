#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [D/N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

D/N
    fraction

EOS


### Input and Output

main: {
    my @parents;
    push @parents, curious_parent(split m{/}, shift, 2);
    push @parents, curious_parent($parents[-1]->@*);
    local $, = ' ';
    say map {join '/', @$_} @parents;
}


### Implementation

# The child nodes are made from the parent's
# - numerator and numerator + denominator
# - numerator + denominator and denominator
# In reverse, the parent depends on the order of the child's denominator
# and numerator and may be reconstructed easily.
sub curious_parent ($d, $n) {
    $d < $n ? [$d, $n - $d] : [$d - $n, $n];	
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        my $parent = curious_parent(3, 5);
        is $parent, [3, 2], 'example 1 parent';
        is curious_parent(@$parent), [1, 2], 'example 1 grandparent';

        $parent = curious_parent(4, 3);
        is $parent, [1, 3], 'example 2 parent';
        is curious_parent(@$parent), [1, 2], 'example 2 grandparent';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
