#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::UtilsBy 'min_by';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [LIST1 LIST2]

-examples
    run the examples from the challenge
 
-tests
    run some tests

LIST1 LIST2
    two lists of comma separated words

EOS


### Input and Output

say "(@{[min_ind_sum(map [split /,/, $_], @ARGV)]})";


### Implementation

sub min_ind_sum ($x, $y) {
    # Build key-value pairs from the strings in @$y and their index
    # position.
    my %hy;
    @hy{@$y} = (0 .. $#$y);

    # Build key-value pairs from the strings in @$x and their index sum
    # within both arrays.
    my %hx;
    @hx{@$x} = do {
        # Add the index positions in @$x and @$y for common strings.
        # Strings in @$x that are missing in @$y produce infinity.
        my $i = 0;
        map $i++ + ($_ // 'inf'), delete @hy{@$x};
    };

    # Select all elements from @$x having a finite minimum index sum.
    min_by {$hx{$_}} grep $hx{$_} < 'inf', @$x;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [min_ind_sum(["Perl", "Raku", "Love"], ["Raku", "Perl", "Hate"])],
            ["Perl", "Raku"], 'example 1';
        is [min_ind_sum(["A", "B", "C"], ["D", "E", "F"])],
            [], 'example 2';
        is [min_ind_sum(["A", "B", "C"], ["C", "A", "B"])],
            ["A"], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
