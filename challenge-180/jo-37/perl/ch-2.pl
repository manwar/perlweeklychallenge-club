#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $trim); 

run_tests() if $tests || $examples;	# does not return
$trim //= -1;

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-trim=LIM] [--] [N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-trim=LIM
    use LIM as trim limit. Default: -1

N1 N2...
    List to be trimmed

EOS

sub trim_low :prototype($\@);


### Input and Output

trim_low($trim, @ARGV);
say "@ARGV";


### Implementation

# The simplistic statement "grep $_ > $i, @n;" cannot be the solution to
# a PWC task.  There must be something beyond that.  I presume the given
# array has to be modified. 
sub trim_low :prototype($\@) ($low, $arr) {
    # Moving backwards over the array simplifies things as removing an
    # element does not change the indices of not yet processed items.
    for (my $i = $#$arr; $i >= 0; $i--) {
        splice @$arr, $i, 1 if $arr->[$i] <= $low;
    }
    # Returning a ref to the modified array.
    $arr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is &trim_low(3, [1, 4, 2, 3, 5]), [4, 5], 'example 1';
        is &trim_low(4, [9, 0, 6, 2, 3, 8, 5]), [9, 6, 8, 5], 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is do {&trim_low(3, my $arr = [1, 4, 2, 3, 5]); $arr},
            [4, 5], 'example 1 - modified array';
        is do {&trim_low(4, my $arr = [9, 0, 6, 2, 3, 8, 5]); $arr},
            [9, 6, 8, 5], 'example 2 - modified array';
	}

    done_testing;
    exit;
}
