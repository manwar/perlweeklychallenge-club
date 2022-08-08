#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'is_prime';
use List::Gen ':iterate';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print the first N palindromic prime cyclops in base 10

Call "$0 20" to solve the task or "$0 23624" for some more fun.

EOS


### Input and Output

gen_palindromic_prime_cyclops()->say(shift);


### Implementation

# Build a generator for palindromic prime cyclops in base 10.
#
# Loop over palindromic cyclops starting with and ending in 1, 3, 7 or 9
# and filter prime numbers.  The approach seems to be useful as this
# sequence can easily be constructed and has large steps.

sub gen_palindromic_prime_cyclops {
    # Map digits to be skipped onto their successor.
    my %next = (0 => 1, 2 => 3, 4 => 7, 8 => 9);

    # Iterator for the head of palindromic cyclops that are prime
    # candidates, i.e. do not end in 2, 4, 5, 6 or 8.
    iterate_stream {
        # Increment the head.  If the result starts with one of the
        # excluded leading digits or contains a zero, map the found
        # digit to the next possible and replace the subsequent digits
        # with ones.  This gives the head of the next possibly prime
        # palindromic cyclops number.
        ($_ + 1) =~ s/(^[248]|0)(.*)/$next{$1} . '1' x length($2)/er;
    }
    ->from(1)
    ->map(sub {
            # Construct the full palindrome from the head.
            $_ . '0' . reverse;
        })
    # ->grep('prime') is *way* to slow.
    ->filter(sub {is_prime $_});
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_palindromic_prime_cyclops()->take(20),
            [101, 16061, 31013, 35053, 38083,
            73037, 74047, 91019, 94049, 1120211, 1150511, 1160611,
            1180811, 1190911, 1250521, 1280821, 1360631, 1390931,
            1490941, 1520251], 'task 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is gen_palindromic_prime_cyclops()->get(26),
            1730371, 'see http://oeis.org/A136098';
	}

    done_testing;
    exit;
}
