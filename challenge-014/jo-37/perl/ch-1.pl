#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print the first N numbers from van Eck's sequence

EOS


### Input and Output

gen_van_eck()->say(shift);


### Implementation

# Build a generator for van Eck's sequence.
sub gen_van_eck {
    # Start the list with two zeros, followed by the recursive sequence.
	([0, 0] + <2..>->map(sub {
                # Take the previously found value.
                my $n = self($_ - 1);
                # Looking backwards, find the next occurence of this
                # value.
                my $m = self()->slice(0 .. $_ - 2)->reverse
                ->first_idx(sub {$_ == $n});
                # Take the index difference as the next value if the
                # value was found or zero otherwise.
                defined $m ? $m + 1: 0;
            })
    # Cache results make the generator available for recursion.
    )->cache->recursive;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
    }

    SKIP: {
        skip "tests" unless $tests;

        is gen_van_eck()->take(97),
        [0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5, 3, 0, 3, 2, 9, 0, 4, 9, 3, 6, 14, 0, 6, 3, 5, 15, 0, 5, 3, 5, 2, 17, 0, 6, 11, 0, 3, 8, 0, 3, 3, 1, 42, 0, 5, 15, 20, 0, 4, 32, 0, 3, 11, 18, 0, 4, 7, 0, 3, 7, 3, 2, 31, 0, 6, 31, 3, 6, 3, 2, 8, 33, 0, 9, 56, 0, 3, 8, 7, 19, 0, 5, 37, 0, 3, 8, 8, 1],
        'from OEIS';
	}

    done_testing;
    exit;
}
