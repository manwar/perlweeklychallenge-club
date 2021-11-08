#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    find the smallest palindromic number larger than N

EOS


### Input and Output

say next_palindrome(shift);


### Implementation

# There are just two cases: either mirroring the left half already leads
# to a larger number or the left half needs to be incremented first.

sub next_palindrome ($n) {
    # Find the innermost symmetry breaking digit pair.
    my ($l, $r);
    for (length($n) / 2 .. length($n) - 1) {
        last if ($l = substr $n, -$_ - 1, 1) != ($r = substr $n, $_, 1);
    }

    # Increment the left half if there is no asymmetry or the
    # digit in the left half is smaller than its right counterpart.
    $n += 10 ** (int length($n) / 2) if $l <= $r;

    # Mirror the left half.
    substr($n, (length($n) + 1) / 2) =
        reverse substr($n, 0, length($n) / 2);

    $n;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is next_palindrome(1234), 1331, 'example 1';
        is next_palindrome(999), 1001, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is next_palindrome(8), 9, 'single digit';
        is next_palindrome(9), 11, 'single digit, carry';
        is next_palindrome(99), 101, 'two digits, carry';
        is next_palindrome(45653), 45654, 'mirror odd';
        is next_palindrome(45645), 45654, 'mirror odd';
        is next_palindrome(45654), 45754, 'increment, odd';
        is next_palindrome(45655), 45754, 'increment, odd';
        is next_palindrome(45663), 45754, 'increment, odd';
        is next_palindrome(45954), 46064, 'increment, odd, carry';
        is next_palindrome(45653), 45654, 'mirror odd';
        is next_palindrome(45645), 45654, 'mirror odd';
        is next_palindrome(45654), 45754, 'increment, odd';
        is next_palindrome(45655), 45754, 'increment, odd';
        is next_palindrome(45663), 45754, 'increment, odd';
        is next_palindrome(45954), 46064, 'increment, odd, carry';
        is next_palindrome(456653), 456654, 'mirror, even';
        is next_palindrome(456645), 456654, 'mirror, even';
        is next_palindrome(456654), 457754, 'increment, even';
        is next_palindrome(456655), 457754, 'increment, even';
        is next_palindrome(456663), 457754, 'increment, even';
        is next_palindrome(456743), 457754, 'increment, even';
        is next_palindrome(456954), 457754, 'increment, even';
        is next_palindrome(459954), 460064, 'increment, even, carry';
	}

    done_testing;
    exit;
}
