#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Coro::Generator;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 3;
usage: $0 [-examples] [-tests] [-verbose] [W1 W2 I]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print intermediate Fibonacci words

W1 W2 I
    generate Fibonacci words from W1 and W2 until the length I is reached
    and pick the Ith character

EOS


### Input and Output

say pick_from_fib_word(@ARGV);


### Implementation

# Generate Fibonacci words from W1 and W2 until the length I is reached
# and pick the Ith character.
sub pick_from_fib_word ($w1, $w2, $i) {
    my $gen = gen_fibonacci_words($w1, $w2);
    my $f = '';
    # Generate the needed word and print it in verbose mode.
    ($f = $gen->(), $verbose) && say $f while $i > length $f;

    substr($f, $i - 1, 1);
}

# Build a generator for the Fibonacci word sequence starting with W1 and
# W2.
sub gen_fibonacci_words ($w1, $w2) {
    generator {
        yield $w1;
        yield $w2;
        while () {
            ($w1, $w2) = ($w2, $w1 . $w2);
            yield $w2;
        }
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is pick_from_fib_word(1234, 5678, 51), 7, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $fib_words = gen_fibonacci_words(1234, 5678);
        is [map $fib_words->(), 1 .. 7],
        [qw(1234 5678 12345678 567812345678 12345678567812345678
        56781234567812345678567812345678
        1234567856781234567856781234567812345678567812345678)],
        'list of fibonacci words';
	}

    done_testing;
    exit;
}
