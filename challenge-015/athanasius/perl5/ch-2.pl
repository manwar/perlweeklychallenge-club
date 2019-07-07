#!perl

################################################################################
=comment

Perl Weekly Challenge 015
=========================

Task #2
-------

Write a script to implement Vigenère cipher. The script should be able encode
and decode. Checkout wiki [ https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher
|page] for more information.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use utf8;
use warnings;
use Const::Fast;
use Getopt::Long;
use POSIX qw( ceil );

# The alphabet for both plaintext and ciphertext: characters must have
# consecutive ordinal values within their character set

# (1) The canonical alphabet: upper case only
const my @ALPHABET  => ('A' .. 'Z');

# (2) Extended alphabet: allows messages and keys to be written in "CamelCase"
#const my @ALPHABET => ('A' .. 'Z', '[', '\\', ']', '^', '_', '`', 'a' .. 'z');

# (3) Full ASCII alphabet
#const my @ALPHABET => map { chr $_ } 32 .. 126;

# Ordinal value of the first character in the alphabet

const my $ORD_BASE  => ord $ALPHABET[0];

# Regular expression to match non-alphabet characters (the first is captured)

const my $NON_ALPHA => eval "qr{ ( [^$ALPHABET[0]-$ALPHABET[-1]] ) }x";

# Default values (from the Wikipedia page)

const my $KEY       => 'LEMON';
const my $PLAINTEXT => 'ATTACKATDAWN';

# Usage message

const my $USAGE => "\nUSAGE: perl $0 [--key <str>] [--plain|message <str>] " .
                                                  "[--cipher <str>]\n";
$| = 1;

MAIN:
{
    my ($key, $plaintext, $ciphertext) = read_command_line();

    if    (( $plaintext &&  $ciphertext) ||
           (!$plaintext && !$ciphertext))
    {
        $plaintext //= $PLAINTEXT;                  # Allow empty string
        my $cipher   = encode($plaintext, $key);
        my $decoded  = decode($cipher,    $key);

        printf "\nWith key '%s', '%s' --> '%s' --> '%s': %s\n",
                  $key, $plaintext, $cipher, $decoded, 
                  $decoded eq $plaintext ? 'Success' : 'Failure';
    }
    elsif ($plaintext)      # Encode only
    {
        printf "\nWith key '%s', '%s' encodes to '%s'\n",
                $key, $plaintext,  encode($plaintext,  $key);
    }
    else                    # Decode only
    {
        printf "\nWith key '%s', '%s' decodes to '%s'\n",
                $key, $ciphertext, decode($ciphertext, $key);
    }
}

sub read_command_line
{
    my ($help, $key, $plaintext, $ciphertext);

    GetOptions
    (
        'help'            => \$help,
        'key:s'           => \$key,
        'plain|message:s' => \$plaintext,
        'cipher:s'        => \$ciphertext,

    ) or die $USAGE;

    die $USAGE if $help;

    $key ||= $KEY;                                  # Disallow empty string

    return ($key, $plaintext, $ciphertext);
}

#-------------------------------------------------------------------------------
=Wikipedia article "Vigenère cipher"

Vigenère can also be described algebraically. If the letters A–Z are taken to be
the numbers 0–25 ( A ≙ 0, B ≙ 1, etc.), and addition is performed modulo 26,
Vigenère encryption E using the key K can be written as

  C_i = E_K(M_i) = (M_i + K_i) mod 26

and decryption D using the key K as

  M_i = D_K(C_i) = (C_i - K_i) mod 26,

in which M = M_1 ... M_n is the message,
         C = C_1 ... C_n is the ciphertext and
         K = K_1 ... K_n is the key obtained by repeating the keyword ⌈n/m⌉
                                    times in which m is the keyword length.
=cut
#-------------------------------------------------------------------------------

sub encode
{
    my ($plaintext, $key) = @_;

    validate('plaintext', $plaintext, $key);

    my @plain =  str2num($plaintext);
    my @key   = (str2num($key)) x ceil(length($plaintext) / length($key));
    my @cipher;

    while (@plain)
    {
        my $m = shift @plain;
        my $k = shift @key;

        push @cipher, ($m + $k) % scalar @ALPHABET;
    }

    return num2str(@cipher);
}

sub decode
{
    my ($ciphertext, $key) = @_;

    validate('ciphertext', $ciphertext, $key);

    my @cipher =  str2num($ciphertext);
    my @key    = (str2num($key)) x ceil(length($ciphertext) / length($key));
    my @plain;

    while (@cipher)
    {
        my $c = shift @cipher;
        my $k = shift @key;

        push @plain, ($c - $k) % scalar @ALPHABET;
    }

    return num2str(@plain);
}

sub validate
{
    my ($name, $text, $key) = @_;

    die "Invalid character '$1' in $name\n" if $text =~ $NON_ALPHA;
    die "Invalid character '$1' in key\n"   if $key  =~ $NON_ALPHA;
}

sub str2num
{
    my ($string) = @_;

    return map { ord($_) - $ORD_BASE } split //, $string;
}

sub num2str
{
    my @nums = @_;

    return join '', map { chr( $_ + $ORD_BASE ) } @nums;
}

################################################################################
