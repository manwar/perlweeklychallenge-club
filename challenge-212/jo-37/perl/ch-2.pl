#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'min';
use List::UtilsBy 'extract_first_by';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [SIZE N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

SIZE
    subgroup size

N...
    list of numbers

EOS


### Input and Output

main: {
    my $r = rearrange(@ARGV);
    local $" = ',';
    local $, = ',';
    say $r ? map "(@$_)", @$r : -1;
}


### Implementation

sub rearrange {
    my $size = shift;
    my @res;
    while (@_) {
        push @res, [];
        my $min = min @_;
        for my $i ($min .. $min + $size - 1) {
            push $res[-1]->@*, extract_first_by {$_ == $i} @_;
        }
        return if $res[-1]->@* != $size;
    }
    \@res;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is rearrange(3, 1,2,3,5,1,2,7,6,3), [[1, 2, 3], [1, 2, 3], [5, 6, 7]],
            'example 1';
        is rearrange(2, 1,2,3), U(), 'example 2';
        is rearrange(3, 1,2,4,3,5,3), [[1, 2, 3], [3, 4, 5]], 'example 3';
        is rearrange(3, 1,5,2,6,4,7), U(), 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
