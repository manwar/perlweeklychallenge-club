#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The Perl solution below transforms the given $N into ($N modulo |A|), where |A|
is the number of letters in the plaintext alphabet A. In this way (and using
the English alphabet of 26 letters), $N = 27 is interpreted as a left shift of
1, and $N = -4 is interpreted as a left shift of 22, which is equivalent to a
*right* shift of 4.

The shift operation is performed by pop()ing letters from the end of the alpha-
bet and unshift()ing them back onto the front. (An alternative approach -- not
used here -- would be to store and access the plaintext alphabet in a circular
array.) Enciphering is implemented using Perl's transliteration operator.

Although not required, deciphering is also implemented: it is simply the
enciphering operation with letters shifted in the opposite direction. If the
$CHECK constant is set to a true value, a sanity check is performed by
deciphering the enciphered message and comparing the result with the original
plaintext.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $CHECK    => 0;
const my @ALPHABET => ( 'A' .. 'Z' );
const my $ALPHABET => join '', @ALPHABET;
const my $SPACES   => " ";
const my $USAGE    =>
"Usage:
  perl $0 <S> <N>

    <S>    String: plaintext containing only uppercase letters and spaces
    <N>    Integer: size of left shift (negative value gives right shift)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 097, Task #1: Caesar Cipher (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($S, $N) = parse_command_line();

    printf qq[Input: \$S = "%s", \$N = %d\n], $S, $N;

    my $cipher = encipher( $S, $N );

    printf qq[Output:     "%s"\n], $cipher;

    if ($CHECK)
    {
        my $plain = decipher( $cipher, $N );

        printf qq[Deciphered: "%s"\nResult:      %s\n], $plain,
                 ($S eq $plain) ? 'Success' : 'Failure';
    }
}

#------------------------------------------------------------------------------
sub encipher
#------------------------------------------------------------------------------
{
    my ($S, $N) = @_;
    my  $cipher = $S;

    unless (($N %= scalar @ALPHABET) == 0)
    {
        my @replace = ($N > 0) ? @ALPHABET : reverse @ALPHABET;

        unshift @replace, pop @replace for 1 .. $N;

        my $replacement = join '', ($N > 0) ? @replace : reverse @replace;

        # A string eval is needed here because the transliteration operator
        # tr/// does not interpolate

        $cipher = eval qq["$S" =~ tr/$ALPHABET/$replacement/r;];
    }

    return $cipher;
}

#------------------------------------------------------------------------------
sub decipher
#------------------------------------------------------------------------------
{
    my ($cipher, $N) = @_;

    return encipher($cipher, -$N);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args < 2                  and error('Too few command-line arguments');
       $args > 2                  and error('Too many command-line arguments');

    my $S =  $ARGV[0];
       $S =~ / ( [^$SPACES$ALPHABET] ) /x
                                  and error("Invalid character '$1' in S");

    my $N =  $ARGV[1];
       $N =~ / ^ $RE{num}{int} $ /x
                                  or  error('Invalid integer N');

    return ($S, $N);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
