#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $plaintext;
my $passphrase;
my $key;
my $ciphertext;

print("\n");

####################
# Encryption
####################
$plaintext =  "Hide the gold in the tree stump";
$passphrase = "playfair example";
$key = playfair_generate_key($passphrase);
printf(
    "Encryption:\n\tPlaintext:  %s\n\tPassphrase: %s\n"
    .
    "\tKey:        %s\n\tCiphertext: %s\n",
    $plaintext,
    $passphrase,
    $key,
    playfair_encrypt($key, $plaintext)
);

print("\n");

####################
# Decryption
####################
$ciphertext = "siderwrdulfipaarkcrw";
$passphrase = "perl and raku";
$key = playfair_generate_key($passphrase);
printf(
    "Decryption:\n\tCiphertext: %s\n\tPassphrase: %s\n"
    .
    "\tKey:        %s\n\tPlaintext:  %s\n",
    $ciphertext,
    $passphrase,
    $key,
    playfair_decrypt($key, $ciphertext)
);

print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Generate a key for use with the Playfair (or Wheatstone-Playfair, if you
# prefer) cipher.
# Takes one argument:
# * The passphrase to use in generating the key; all non-alphabetic characters
#   will be ignored, and characters beyond the 25th unique letter will not be
#   significant
# Returns:
# * The computed key, which will consist of a string of 25 unique upper-case
#   letters whose order depends on the content of the passphrase
# See https://en.wikipedia.org/wiki/Playfair_cipher for a description of the
# cipher
################################################################################
sub playfair_generate_key{
    my $passphrase = uc(shift());

    my %alphabet = (
        A => 1,  B => 1,  C => 1,  D => 1,  E => 1,
        F => 1,  G => 1,  H => 1,  I => 1,  K => 1,
        L => 1,  M => 1,  N => 1,  O => 1,  P => 1,        
        Q => 1,  R => 1,  S => 1,  T => 1,  U => 1,
        V => 1,  W => 1,  X => 1,  Y => 1,  Z => 1
    );
    my $key;

    # Remove all non-alphabetic characters from
    # the passphrase, and convert all J's to I's
    $passphrase =~ s/[^A-Z]//g;
    $passphrase =~ s/J/I/g;

    # Split the passphrase and loop over each
    # letter...
    foreach my $chr (split("", $passphrase)){
        # See if this letter has been used...
        if($alphabet{$chr}){
            # This letter has not been used yet; add
            # it to the key and delete it from the
            # alphabet table
            $key .= $chr;
            delete($alphabet{$chr});
        }
    }

    # Add what letters haven't been used yet to
    # the key and return it
    return($key . join("", sort(keys(%alphabet))));

}



################################################################################
# Encrypt a message using the Playfair (or Wheatstone-Playfair, if you prefer)
# cipher.
# Takes two arguments:
# * A previously-generated encryption/decryption key (see documentation for
#   playfair_generate_key() for more details)
# * The plaintext message to encrypt
# Returns on success:
# * The encrypted ciphertext
# Returns on error:
# * undef if the key does not have exactly 25 characters
# See https://en.wikipedia.org/wiki/Playfair_cipher for a description of the
# cipher
################################################################################
sub playfair_encrypt{
    my $key = shift();
    my $plaintext = uc(shift());

    return(undef)
        unless(length($key) == 25);

    # Strip non-alphabetical characters from the
    # plaintext
    $plaintext =~ s/[^A-Z]//g;

    # Convert J's to I's
    $plaintext =~ s/J/I/g;

    # Rule 1 - divide the string into pairs and
    # insert X's when pairs of repeated letters
    # are observed, and pad the end with an X if
    # if the final string length would have been
    # odd
    $ARG = "";
    while($plaintext =~ s/^(..?)//){
        my $pair = $1;

        if(length($pair) == 1){
            # Lone letter- add an X to make a pair
            $pair .= "X";
        } elsif($pair =~ m/(.)\1/){
            # Repeated letter- put the second back
            # into the plaintext string and replace
            # it with an X in this pair
            substr($plaintext, 0, 0, $1);
            $pair = $1 . "X";
        }

        $ARG .= $pair;

    }

    # $plaingext now actually contains a reference
    # to ciphertext...
    $plaintext = _playfair_process_core($key, \$ARG, 1);

    return($$plaintext);

}



################################################################################
# Decrypt a message that has been encrypted with the Playfair (or
# Wheatstone-Playfair, if you prefer) cipher.
# Takes two arguments:
# * A previously-generated encryption/decryption key (see documentation for
#   playfair_generate_key() for more details); this message must have an even
#   number of characters, which proper encryption will have taken care of
# * The ciphertext message to decrypt
# Returns on success:
# * The decrypted plaintext- which will have I's in place of J's wherever they
#   occurred in the original message, and may contain extraneous X's if the
#   original message required adjustment for duplicate pairs, or padding to
#   reach an even length (see the article linked below)
# Returns on error:
# * undef if the key does not have exactly 25 characters, or the ciphertext
#   does not have an even number of characters
# See https://en.wikipedia.org/wiki/Playfair_cipher for a description of the
# cipher
################################################################################
sub playfair_decrypt{
    my $key = shift();
    my $ciphertext = uc(shift());

    return(undef)
        unless(
            (length($key) == 25) && !(length($ciphertext) % 2)
        );

    # $ciphertext now actually contains a reference
    # to plaintext...
    $ciphertext = _playfair_process_core($key, \$ciphertext, -1);

    return($$ciphertext);

}



################################################################################
# Handle many of the internal details of the Playfair (or Wheatstone-Playfair,
# if you prefer) cipher; this covers both encryption and decryption (see below)
# Takes three arguments:
# * A previously-generated encryption/decryption key (see documentation for
#   playfair_generate_key() for more details)
# * A reference to the text to encrypt or decrypt, which must consist of an
#   even number of characters; if this is plaintext to encrypt, the message
#   must already have had duplicate pairs processed and its length padded (see
#   the article linked below)
# * An offset constant to use in certain cases where the characters of a pair
#   are in the same row or column; in the classic Playfair cipher, this must be
#   1 for encryption, and -1 for decryption
# Returns:
# * A reference to the processed text, which will either be ciphertext or
#   plaintext depending on the selected operation
# See https://en.wikipedia.org/wiki/Playfair_cipher for a description of the
# cipher
# NOTE: This function should ONLY be called by playfair_encrypt() or
# playfair_decrypt() as those functions perform necessary operations and sanity
# checks on the inputs passed to this function
################################################################################
sub _playfair_process_core{
    use v5.6.0;

    my $key = shift();
    my $intext = shift();
    my $mode_offset = shift();

    my $outtext = "";

    # Loop over each pair of characters from the
    # input text...
    while($$intext =~ s/^(..)//){
        my $pair = $1;
        my @x;
        my @y;

        # Loop over each character in the pair...
        foreach my $index (0 .. 1){
            my $chr = substr($pair, $index, 1);

            # Find the character within the key and use $-[0]
            # to calculate its X and Y coordinates (zero-
            # indexed) within the key if interpreted as a 5x5
            # matrix
            $key =~ m/$chr/;
            $x[$index] = $-[0] % 5;
            $y[$index] = int($-[0] / 5); 
        }
        
        # Compute the coordinates of the replacement
        # characters, based on established rules
        if($y[0] == $y[1]){
            # Rule 2 - same row
            $x[0] = ($x[0] + $mode_offset) % 5;
            $x[1] = ($x[1] + $mode_offset) % 5;
        } elsif($x[0] == $x[1]){
            # Rule 3 - same column
            $y[0] = ($y[0] + $mode_offset) % 5;
            $y[1] = ($y[1] + $mode_offset) % 5;
        } else{
            # Rule 4 - rectangle
            ($x[0], $x[1]) = ($x[1], $x[0]);
        }

        # Add two characters from the key to the output,
        # converting the coordinates to a position within
        # the 1-D key string
        $outtext .= 
            substr($key, 5 * $y[0] + $x[0], 1)
            .
            substr($key, 5 * $y[1] + $x[1], 1);
    }

    return(\$outtext);

}



