#!/usr/bin/perl

use strict;
use warnings;

# Define the Chaocipher alphabets
my $left_alphabet  = "HXUCZVAMDSLKPEFJRIGTWOBNYQ";
my $right_alphabet = "PTLNBQDEOYSFAVZKGJRIHWXUMC";

sub chaocipher_encrypt {
    my $message     = shift;
    my $ciphertext  = "";
    my $left_index  = 0;
    my $right_index = 0;

    # Loop through each character in the message
    foreach my $char ( split //, uc($message) ) {
        if ( $char !~ /[A-Z]/ ) {

            # Ignore non-alphabetic characters
            $ciphertext .= $char;
            next;
        }

        # Find the index of the character in the left alphabet
        my $left_char_index = index( $left_alphabet, $char );

        # Swap the left and right indices
        ( $left_index, $right_index ) = ( $right_index, $left_index );

        # Find the corresponding character in the right alphabet
        my $right_char =
          substr( $right_alphabet, ( $left_char_index + $right_index ) % 26,
            1 );

        # Append the encrypted character to the ciphertext
        $ciphertext .= $right_char;
    }

    return $ciphertext;
}

sub chaocipher_decrypt {
    my $ciphertext  = shift;
    my $plaintext   = "";
    my $left_index  = 0;
    my $right_index = 0;

    # Loop through each character in the ciphertext
    foreach my $char ( split //, uc($ciphertext) ) {
        if ( $char !~ /[A-Z]/ ) {

            # Ignore non-alphabetic characters
            $plaintext .= $char;
            next;
        }

        # Find the index of the character in the right alphabet
        my $right_char_index = index( $right_alphabet, $char );

        # Swap the left and right indices
        ( $left_index, $right_index ) = ( $right_index, $left_index );

        # Find the corresponding character in the left alphabet
        my $left_char =
          substr( $left_alphabet, ( $right_char_index - $right_index ) % 26,
            1 );

        # Append the decrypted character to the plaintext
        $plaintext .= $left_char;
    }

    return $plaintext;
}

# Example usage
my $message    = "Hello World!";
my $ciphertext = chaocipher_encrypt($message);
print "Ciphertext: $ciphertext\n";
my $plaintext = chaocipher_decrypt($ciphertext);
print "Plaintext: $plaintext\n";
