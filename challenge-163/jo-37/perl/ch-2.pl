#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'reductions';
use experimental 'signatures';

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [N...]

-examples
    run the examples from the challenge
 
N...
    Calculate the "triangular sum" over the given numbers.

EOS


### Input and Output

say triangular_sum(@ARGV);


### Implementation

sub triangular_sum (@n) {
    # Calculate the running sums over the array starting with the second
    # element until the array becomes a singleton.
    @n = reductions {$a + $b} @n[1 .. $#n] while @n > 1;

    $n[0];
}


### Examples and tests

sub run_tests {

    # Meeting Slartibartfast, again.
    is triangular_sum(1, 2, 3, 4, 5), 42, 'example 1';
    is triangular_sum(1, 3, 5, 7, 9), 70, 'example 2';

    done_testing;
    exit;
}
