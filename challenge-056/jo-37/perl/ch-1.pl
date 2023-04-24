#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 2;
usage: $0 [-examples] [-tests] [K N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

K
    desired difference between two list elements

N1 N2...
    list of numbers

EOS


### Input and Output

main: {
    local $" = ',';
    local $, = ',';
    say map "(@$_)", diff_k(@ARGV)->@*;
}


### Implementation

# Take the difference of all pairs, invalidate the diagonal and find all
# matching indices.
sub diff_k {
	my $k = shift;
    my $l = long @_;
    $l->badflag(1);
    my $d = $l - $l->dummy(0);
    $d->diagonal(0, 1) .= $d->badvalue;

    whichND($d == $k)->unpdl;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
       
        is diff_k(2, 2,7,9), [[2, 1]], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is diff_k(0, 1,2,2), bag {item [1,2]; item [2,1]; end;},  'i != j';
	}

    done_testing;
    exit;
}
