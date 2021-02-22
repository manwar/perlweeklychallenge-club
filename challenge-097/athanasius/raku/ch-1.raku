use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 097
=========================

Task #1
-------
*Caesar Cipher*

Submitted by: Mohammad S Anwar

You are given string $S containing alphabets A..Z only and a number $N.

Write a script to encrypt the given string $S using [ https://en.wikipedia.org/ wiki/Caesar_cipher |Caesar Cipher] with left shift of size $N.

Example

 Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
 Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"

 Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
 Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW

 Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
 Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

The Raku solution below transforms the given $N into ($N modulo A), where A is
the number of letters in the plaintext @ALPHABET. In this way (and using the
English alphabet of 26 letters), $N = 27 is interpreted as a left shift of 1,
and $N = -4 is interpreted as a left shift of 22, which is equivalent to a
*right* shift of 4.

The shift operation is performed by pop()ing letters from the end of the alpha-
bet and unshift()ing them back onto the front. (An alternative approach -- not
used here -- would be to store and access the plaintext alphabet in a circular
array.) Enciphering is implemented using Raku's trans()literation routine.

Although not required, deciphering is also implemented: it is simply the
enciphering operation with letters shifted in the opposite direction. If the
$CHECK constant is set to True, a sanity check is performed by deciphering the
enciphered message and comparing the result with the original plaintext.

=end comment
#==============================================================================

my Bool constant $CHECK    = False;
my      constant @ALPHABET = Array[Str].new( 'A' .. 'Z' );
my Str  constant $ALPHABET = @ALPHABET.join: '';
my Str  constant $SPACES   = '\x[0020]';

my regex Alphabet { <{ "<[ $ALPHABET ]>" }> }
my regex Spaces   { <{ "<[ $SPACES   ]>" }> }

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 097, Task #1: Caesar Cipher (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| String: plaintext containing only uppercase letters and spaces

    Str:D $S where { $S ~~ / ^ ( <Alphabet> || <Spaces> )* $ / },

    Int:D $N  #= Integer: size of left shift (negative value gives right shift)
)
#==============================================================================
{
    qq[Input: \$S = "%s", \$N = %d\n].printf: $S, $N;

    my Str $cipher = encipher( $S, $N );

    qq[Output:     "%s"\n].printf: $cipher;

    if $CHECK
    {
        my Str $plain = decipher( $cipher, $N );

        qq[Deciphered: "%s"\nResult:      %s\n].printf:
            $plain, ($S eq $plain) ?? 'Success' !! 'Failure';
    }
}

#------------------------------------------------------------------------------
sub encipher( Str:D $S, Int:D $N --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $cipher = $S;
    my Int $shift  = $N % @ALPHABET.elems;

    unless $shift == 0
    {
        my Str @replace = @ALPHABET;
               @replace = @replace.reverse if $shift < 0;

               @replace.unshift: @replace.pop for 1 .. $shift;

               @replace = @replace.reverse if $shift < 0;

        $cipher = $S.trans( $ALPHABET => @replace.join: '' );
    }

    return $cipher;
}

#------------------------------------------------------------------------------
sub decipher( Str:D $cipher, Int:D $N --> Str:D )
#------------------------------------------------------------------------------
{
    return encipher( $cipher, -$N );
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
