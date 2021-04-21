#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(forperm);
use List::Util qw(sum uniqnum);
use experimental qw(signatures);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 7;
usage: $0 [-examples] [-tests] [--] [A B C D E F G]

-examples
    run the examples from the challenge
 
-tests
    run some tests

A B C D E F G
    numbers

EOS


### Input and Output

format top =
     a      b      c      d      e      f      g
     =      =      =      =      =      =      =
.

format =
@>>>>> @>>>>> @>>>>> @>>>>> @>>>>> @>>>>> @>>>>>
@$_
.

write for @{puzzle(@ARGV)};


### Implementation

# A brute force approach:
# Iterate over all permutations of the given numbers, assign them to the
# boxes and select those having equal box sums.

# index-to-box assignments: 
use constant BOX => ([0, 1], [1, 2, 3], [3, 4, 5], [5, 6]);

sub puzzle (@num) {

    # Iterate over all permutations.
    my @puzzle;
    forperm {
        # Sum over the the numbers contained in each box and count the
        # unique values thereof.  Collect a solution if the sums consist
        # of a single value.
        # Double slice: pick the indices belonging to the current
        # box from the permutation and then collect the respective
        # numbers.
        push @puzzle, [@num[@_]]
            if uniqnum(map {sum @num[@_[@$_]]} BOX) == 1;
    } @num;

    \@puzzle;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is puzzle(1 .. 7), bag {item [qw(6 4 1 5 2 3 7)]; etc}, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        # No two pairs have the same sum, thus there cannot be a solution:
        is puzzle(1, 2, 4, 8, 16, 32, 64), [], 'no solution';

        is puzzle(-1.1, 0, 1.1, 2.2, 3.3, 4.4, 5.5),
            bag {item [3.3, 2.2, -1.1, 4.4, 1.1, 0, 5.5]; etc},
            'include negative floating point numbers';
	}

    done_testing;
    exit;
}
