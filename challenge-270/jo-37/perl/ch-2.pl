#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL v2.077; # for minimum_n_ind
use PDL::NiceSlice;
use experimental 'signatures';

our ($tests, $examples, $verbose, $x, $y);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless defined $x && defined $y && @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-x=X -y=Y INT...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show intermediate steps

-x=X
    cost for 'level 1' operations

-y=Y
    cost for 'level 2' operations

INT...
    list of integers
EOS


### Input and Output

say equalize_array($x, $y, @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/05/24/ch-270.html#task-2


sub equalize_array ($x, $y, @ints) {
    my $ints = pdl @ints;
    return 0 if $ints->dim(0) < 2;
    my $target = maximum $ints;
    return $x * ($ints->dim(0) * $target - sum($ints)) if $y >= 2 * $x;
    my $cost = 0;
    while () {
        say $ints if $verbose;
        my $min = $ints->index(minimum_n_ind($ints, 2));
        return $cost + $x * ($target - $min((0))) if $min((1)) == $target;
        $min += 1;
        $cost += $y;
    }
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is equalize_array(3, 2 ,=> 4, 1), 9, 'example 1';
        is equalize_array(2, 1 ,=> 2, 3, 3, 3, 5), 6, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
