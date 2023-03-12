#!/usr/bin/perl -s

use v5.16;
use Test2::V0;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    sorted list of numbers

EOS


### Input and Output

say compact(@ARGV);


### Implementation

# Join list elements with commas, replace commas between successive
# numbers with hyphens, remove elements enclosed with hyphens and
# finally replace hyphens between successive numbers with commas.
sub compact {
    join(',',  @_) =~ s/(\d+)\K,(?=(\d+))/$2 == $1 + 1 ? '-' : ','/egr
    =~ s/-\d+(?=-)//gr
    =~ s/(\d+)\K-(?=(\d+))/$2 == $1 + 1 ? ',' : '-'/egr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is compact(1,2,3,4,9,10,14,15,16), '1-4,9,10,14-16', 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
