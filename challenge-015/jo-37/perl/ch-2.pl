#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use experimental 'signatures';

our ($tests, $examples, $decrypt, $key);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1 && $key;
usage: $0 -key=KEY [-decrypt] TEXT

-key=KEY
    use KEY for en-/decryption

-decrypt
    decrypt TEXT. (Default: encrypt)

TEXT
    en- or decrypt TEXT

EOS


### Input and Output

say vigenere($key, shift, !$decrypt);


### Implementation

sub vigenere ($key, $text, $enc) {
    # Convert the lowercase text to offsets from 'a'.
    my $t = byte map ord() - ord('a'), split //, lc $text;
    # Convert the lowercase key to offsets from 'a' and periodically
    # extend it to text's length.
    my $k = byte(map ord() - ord('a'), split //, lc $key)
        ->range(0, $t->dim(0), 'p');

    # Add or substract text and key, take the result mod 26 and convert
    # back to characters.
    join '', map chr($_ + ord('a')), (($t + (-1)**!$enc * $k) % 26)->list;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is vigenere('lemon', 'attackatdawn', 1), 'lxfopvefrnhr',
            'encoding example from Wiki';
        is vigenere('lemon', 'lxfopvefrnhr', 0), 'attackatdawn',
            'decoding example from Wiki';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
