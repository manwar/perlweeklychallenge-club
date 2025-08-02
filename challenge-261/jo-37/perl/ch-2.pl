#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 1;
usage: $0 [-examples] [-tests] [--] [START N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

START
    starting value

N...
    list of numbers

EOS


### Input and Output

say mb2(@ARGV);


### Implementation

sub mb2 ($start, @ints) {
    my $p = 0;
    for my $i (@ints) {
        next if $i % $start;
        my $c = $i / $start;
        $p |= $c unless $c & ($c - 1);

    }
    $start * (($p + 1) & ~$p);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        is mb2(3 ,=> 5,3,6,1,12), 24, 'example 1';
        is mb2(1 ,=> 1,2,4,3), 8, 'example 2';
        is mb2(2 ,=> 5,6,7), 2, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
        is mb2(3 ,=> 6, 12, 1, 2), 3, 'none found';
        is mb2(3 ,=> 3, 0), 6, 'has zero';
        is mb2(-3 ,=> -3, -6), -12, 'negative';
        is mb2(2 ,=> 2, 4, 8), 16, 'powers of two';
        is mb2(3 ,=> 3, 9), 6, 'not a power of two';
        is mb2(5 ,=> 0, 1, 2, 3, 4), 5, 'zero only';
        is mb2(5 ,=> 1, 2, 3, 4), 5, 'empty target list';
	}

    done_testing;
    exit;
}
