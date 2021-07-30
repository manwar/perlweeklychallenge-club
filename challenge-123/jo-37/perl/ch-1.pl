#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';
use Coro::Generator;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [-verbose] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print intermediate results

N
    calculate the N-th Hamming number

EOS


### Input and Output

say hamming(pop);


### Implementation

# I have no idea why one would call the sequence A051037 "ugly numbers".
# Wikipedia calls them "regular" (after some discussion about a proper
# name), OEIS "5-smooth" and others "Hamming" numbers.  I'll call them
# "Hamming numbers" in the following.
#
# Generating the Hamming numbers is known as "Hamming's problem".
# Evolved implementations follow a path of augmenting the initial
# one-element sequence (1) with a merger of its own 2-, 3- and 5-fold.
# The most advanced I could find was David Eppstein's Python
# implementation, see last reference.  The implementation here is just a
# plain Perl port of his.  Python has a built-in "yield" statement,
# which makes a Perl port look a bit involved at first, until I
# discovered "Coro::Generator" leading to a straightforward solution.
# My first naive implementation (based on the exclusion of non-Hamming
# numbers) needed 30s to find hamming(1000), whereas now hamming(10000)
# can be calculated in the wink of an eye.  Or consider:
# 'time' perl -Mbigint ch-1.pl 1000000
# 519312780448388736089589843750000000000000000000000000000000000000000000000000000000
# 20.52user 0.30system 0:20.86elapsed 99%CPU (0avgtext+0avgdata 707232maxresident)k
#0inputs+0outputs (0major+175730minor)pagefaults 0swaps 0inputs+0outputs (0major+259495minor)pagefaults 0swaps
#
# References:
# https://en.wikipedia.org/wiki/Regular_number
# http://oeis.org/A051037
# https://11011110.github.io/blog/2007/03/12/hammings-problem.html
# (cool: 0b11011110 == 0xDE)

# Build a generator for powers of $p.
sub powers ($p) {
    generator {
        my $pow = 1;
        while () {
            yield $pow;
            $pow *= $p;
        }
    }
}

# Build a generator for a merged sequence of the one provided by the
# generator $s with itself multiplied by $p.
sub powtimes ($s, $p) {
    generator {
        # Initialize the cache with the first generated value.
        my @seq = $s->();
        # The first element comes from the generated sequence.
        yield $seq[0];
        # Initial "front" element taken from the sequence.
        my $front = $s->();
        # Initial "back" element taken as the $p-fold of the first
        # element from the cache.
        my $back = $seq[my $backindex = 0] * $p;
        while () {
            # Merge the generated sequence with its $p-fold multiple:
            # Select the next element as the smaller of the front
            # element provided by the generator and the back element as
            # the p-fold of the current cached element, advancing these
            # accordingly from the generator or the cache.
            if ($front < $back) {
                yield $front;
                push @seq, $front;
                $front = $s->();
            } else {
                yield $back;
                push @seq, $back;
                $back = $seq[++$backindex] * $p;
            }
        }
    }
}

# Calculate the n-th Hamming number.
sub hamming ($n) {
    # Build a generator for the Hamming numbers.
    my $hamming = powtimes(powtimes(powers(2), 3), 5);
    # Loop over the first $n - 1 hamming numbers and print these if
    # requested.
    sub {say pop if $verbose}->($hamming->()) for 1 .. $n - 1;

    # Return the n-th Hamming number.
    $hamming->();
}

### Examples and tests

sub run_tests {
    local $verbose;
    SKIP: {
        skip "examples" unless $examples;

        is hamming(7), 8, 'example 1';
        is hamming(10), 12, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is hamming(62), 405, 'the largest number given in OEIS';
        is hamming(1000), 51200000, 'fast enough for larger numbers';
        is hamming(10000), 288325195312500000, 'even larger';
        is hamming(13282), 18432000000000000000,
            'the largest fitting into an uint64';
        # Beyond this we have to "use bigint" as hamming(13283) is
        # 2**64.
	}

    done_testing;
    exit;
}
