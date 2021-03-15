#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples, $verbose, $size);

run_tests() if $tests || $examples;    # does not return

say(<<EOS), exit unless defined $size && @ARGV == 1;
usage: $0 [-examples] [-tests] [-verbose] [-size=n bitstring]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show individual bit flips

-size=n
    split <bitstring> into chunks of <n> bits.

bitstring
    binary string

EOS


### Input and Output

say minimum_flips(split_bits($ARGV[0], $size));


### Implementation

# Split given bitstring into chunks of n bits.
sub split_bits ($bitstring, $n) {
    unpack "(A$n)*", $bitstring;
}

# Find the minimum number of bit flips to turn each given bitstring into
# a common target.  The target need not be one of the given bitstrings.
# (This would be a completely different task otherwise.)
sub minimum_flips (@bitstring) {

    # Create 2-d byte piddle as bit matrix from bitstrings.
    my $bits = byte map [split //], @bitstring;

    # Calculate the target bitstring: Set a target bit to one if the bit
    # is set at this position in more than half the bitstrings.
    my $target = $bits->transpose->sumover > $bits->dim(1) / 2;

    explain_bits($bits, $target) if $verbose;

    # The total number of bits to be flipped is the number of bits that
    # deviate from the target over all bitstrings.
    sum $bits ^ $target;
}

# Show internals of the minimum flip solution.
sub explain_bits ($bits, $target) {
    say "bitstrings:", $bits;
    say "target:\n $target\n";
    say "flipbits:", $bits ^ $target;
    say "total flips: ", sum $bits ^ $target;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is [split_bits('101100101', 3)], [qw(101 100 101)], 'example 1 split';
        is minimum_flips(qw(101 100 101)), 1, 'example 1 minimum';
        is [split_bits('10110111', 4)], [qw(1011 0111)], 'example 2 split';
        is minimum_flips(qw(1011 0111)), 2, 'example 2 minimum';
    }

    SKIP: {
        skip "tests" unless $tests;
        is [split_bits('110101011', 3)], [qw(110 101 011)], 'split';
        is minimum_flips(qw(110 101 011)), 3, 'towards one';
        is minimum_flips(qw(100 010 001)), 3, 'towards zero';
        is minimum_flips(qw(1001 0110 1010 0101)),
            8, 'even number of chunks';
        is minimum_flips(1), 0, 'single bit';
        is minimum_flips(qw(001 010 011 100 101 110 111)),
            9, '1..7';

        # Results of inappropriate input.
        is [split_bits('1001', 3)], [qw(100 1)], 'incomplete last chunk';
        is minimum_flips(qw(100 1)), 0, 'unusual zero padding';
    }

    done_testing;
    exit;
}
