#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Utils qw(log2 ceil);
use experimental qw(signatures postderef);

our ($tests, $examples, $decompress);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-decompress] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-decompress
    decompress bitstring

STR
    String made of capital letters (for compression) or 0/1 (for decompression)

EOS


### Input and Output

say $decompress ? lzw_decompress($ARGV[0]) : lzw_compress($ARGV[0] . '#');


### Implementation

# Following the description in the Wiki article with '#' as the
# end-of-string marker encoded as zero and a remaining dictionary of 'A'
# - 'Z'.  Not packing the resulting bits for better visibility.

use constant DICT => ('#', 'A' .. 'Z');

sub lzw_compress ($s) {
    $s =~ tr/[A-Z]#//cd;
    my @dict = DICT;
    my $outbits;
    while () {
        # Current code length
        my $bits = ceil log2 scalar @dict;
        my $dict_ind;
        my $len;
        # Find the longest dictionary entry matching the string head.
        for ($len = 1;; $len++) {
            my $found;
            for (my $ind = 0; $ind < @dict; $ind++) {
                ($dict_ind, $found) = ($ind, 1)
                    if substr($s, 0, $len) eq $dict[$ind];
            }
            last unless $found;
        }
        # Encode the string head as the found entry.
        $outbits .= sprintf "%0*b", $bits, $dict_ind;
        # Create a new dictionary entry from the matched head and the
        # next character and remove the matched head.
        push @dict, substr($s, 0, $len - 1, '') . substr($s, 0, 1);
        if (substr($s, 0, 1) eq '#') {
            $outbits .= sprintf("%0*b", $bits, 0);
            last;
        }
    }
    $outbits;
}

sub lzw_decompress ($s) {
    $s =~ tr/01//cd;
    my @dict = DICT;
    my $outtext;
    while () {
        # Current code length
        my $bits = ceil log2 scalar @dict;
        # Pick bits in the current length and convert to integer.
        my $code = oct "0b" . substr $s, 0, $bits, '';
        # Replace a question mark in the previous dictionary entry with
        # the start character of the selected entry.
        $dict[-1] =~ s/\?/substr $dict[$code], 0, 1/e;
        # Add an incomplete new entry to the dictionary. Its last
        # character is still unknown.
        push @dict, "$dict[$code]?";
        # Collect the dictionary entry in the result.
        $outtext .= $dict[$code];
        last if $dict[$code] eq '#';
    }
    $outtext;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is lzw_compress("TOBEORNOTTOBEORTOBEORNOT#"),
        "101000111100010001010111110010001110001111010100011011011101011111100100011110100000100010000000", 'compression example from Wiki';
        is lzw_decompress("101000111100010001010111110010001110001111010100011011011101011111100100011110100000100010000000"),
        "TOBEORNOTTOBEORTOBEORNOT#", 'decompression example from Wiki';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
