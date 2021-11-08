#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use Math::Prime::Util qw(fromdigits todigits);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [--] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    check if N in binary notation is a palindrome.

EOS


### Input and Output

say 0 + !!bin_pal(shift);


### Implementation

# Check if the given integer (as string or number) in its binary
# representation is a palindrome.

sub bin_pal {
    # Convert the given number into a byte piddle made of its binary
    # digits.
	my $n = byte todigits shift, 2;
    
    # Xor the piddle with its reverse and check that none of the
    # resulting elements is set.
    !any $n ^ $n->slice('-1:0');
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is bin_pal(5), T(), 'example 1';
        is bin_pal(4), F(), 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        my @head = '1';
        push @head, int rand 2 for 0 .. 2047;

        my $n = fromdigits([@head, reverse @head], 2);
        is bin_pal($n), T(),
            'random 4096 bit binary palindrome';
        is bin_pal($n - 1), F(),
            'one off random binary palindrome';
	}

    done_testing;
    exit;
}
