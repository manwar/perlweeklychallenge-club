#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(factor nth_semiprime logint);
use List::MoreUtils 'distinct';
use Math::Utils 'log10';
use Coro::Generator;
use experimental 'signatures';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-base=B] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    Find brilliant numbers in base B.

N
    Print the first N brilliant numbers.

EOS


### Input and Output

main: {
    my $brilliant = brilliant($base);
    say $brilliant->() for 1 .. shift;
}


### Implementation

# Build a generator for brilliant numbers in base B by filtering
# the sequence of all semiprimes.
sub brilliant ($b) {
    my $n;
    generator {
        while () {
            # Emulate "next_semiprime()".
            my $sp = nth_semiprime(++$n);
            # Filter prime factors having the same length in base B.
            yield $sp if 1 == distinct map logint($_, $b), factor $sp;
        }
    };
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $brilliant = brilliant(10);
        is [map $brilliant->(), 1 .. 20], [4, 6, 9, 10, 14, 15, 21, 25, 35,
            49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299],
            'task 1';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $brilliant10 = brilliant(10);
        is [map $brilliant10->(), 1 .. 55], [4, 6, 9, 10, 14, 15, 21, 25,
            35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299,
            319, 323, 341, 361, 377, 391, 403, 407, 437, 451, 473, 481,
            493, 517, 527, 529, 533, 551, 559, 583, 589, 611, 629, 649,
            667, 671, 689, 697, 703, 713, 731, 737, 767, 779, 781],
            'A078972';

        my $brilliant2 = brilliant(2);
        is [map $brilliant2->(), 1 .. 46], [4, 6, 9, 25, 35, 49, 121,
            143, 169, 289, 323, 361, 391, 437, 493, 527, 529, 551, 589,
            667, 713, 841, 899, 961, 1369, 1517, 1591, 1681, 1739, 1763,
            1849, 1927, 1961, 2021, 2173, 2183, 2209, 2257, 2279, 2419,
            2491, 2501, 2537, 2623, 2773, 2809],
            'A085721';
	}

    done_testing;
    exit;
}
