#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 3;
usage: $0 [-examples] [-tests] [TARGET N1 N2 N3...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

TARGET
    target sum for three summands

N1 N2 N3
    list of at least three numbers

EOS


### Input and Output

main: {
    local $" = ',';
    local $, = ',';
    say map "(@$_)", three_sum(@ARGV)->@*;
}


### Implementation

# Taken from https://en.wikipedia.org/wiki/3SUM#Quadratic_algorithm:
# Look up the required complement for each pair in a hash table.

sub three_sum {
    my $target = shift;
    my @l = sort {$a <=> $b} @_;

    my %l;
    @l{@l} = ();
    my @res;
    for my $p (0 .. $#l - 2) {
        my $a = $l[$p];
        for my $q ($p + 1 .. $#l - 1) {
            my $b = $l[$q];
            my $c = $target - $a - $b;
            push @res, [$a, $b, $c] if $c >= $b && exists $l{$c}
        }
    }
    \@res;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is three_sum(0, -25, -10, -7, -3, 2, 4, 8, 10), 
            bag {item [-10, 2, 8]; etc;}, 'example';

    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
