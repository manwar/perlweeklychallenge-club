use v6;

################################################################################
=begin comment

Perl Weekly Challenge 015
=========================

Task #2
-------

Write a script to implement Vigenère cipher. The script should be able encode
and decode. Checkout wiki [ https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher
|page] for more information.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use MONKEY-SEE-NO-EVAL;

# The alphabet for both plaintext and ciphertext: characters must have
# consecutive ordinal values within their character set

# (1) The canonical alphabet: upper case only
my constant @ALPHABET = ('A' .. 'Z');

# (2) Extended alphabet: allows messages and keys to be written in "CamelCase"
#my constant @ALPHABET = ('A' .. 'Z', '[', '\\', ']', '^', '_', '`', 'a' .. 'z');

# (3) Full ASCII alphabet
#my constant @ALPHABET = (32 .. 126).map: { chr $_ };

# Ordinal value of the first character in the alphabet

my UInt constant $ORD-BASE = ord @ALPHABET[0];

# Regular expression to match non-alphabet characters (the first is captured)

my constant $NON-ALPHA = EVAL 'rx/ ( <-[' ~ @ALPHABET.join('') ~ ']> ) /';

# Default values (from the Wikipedia page)

my Str constant $KEY       = 'LEMON';
my Str constant $PLAINTEXT = 'ATTACKATDAWN';

sub MAIN
(
    Bool :$help,                #= this usage message
    Str  :$key = $KEY,          #= key to encode and/or decode
    Str  :message(:$plain),     #= plaintext to be encoded
    Str  :$cipher,              #= ciphertext to be decoded
)
{
    die 'Empty key' unless $key;

    if    ($help)
    {
        say "\n$*USAGE";
    }
    elsif (( $plain &&  $cipher) ||
           (!$plain && !$cipher))
    {
        my $plaintext   = $plain // $PLAINTEXT;     # Allow empty string
        my $ciphertext  = encode($plaintext,  $key);
        my $decodedtext = decode($ciphertext, $key);

        say "\nWith key '$key', '$plaintext' --> '$ciphertext' --> ",
              "'$decodedtext': ",
                $decodedtext eq $plaintext ?? 'Success' !! 'Failure';
    }
    elsif ($plain)      # Encode only
    {
        say "\nWith key '$key', '$plain' encodes to ",
              "'{ encode($plain, $key) }'";
    }
    else                # Decode only
    {
        say "\nWith key '$key', '$cipher' decodes to ",
              "'{ decode($cipher, $key) }'";
    }
}

#-------------------------------------------------------------------------------
=begin wp

From the Wikipedia article "Vigenère cipher":

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

=end wp
#-------------------------------------------------------------------------------

sub encode(Str:D $plaintext, Str:D $key)
{
    validate('plaintext', $plaintext, $key);

    my      @plain =  str2num($plaintext);
    my UInt $mult  =  ceiling($plaintext.chars / $key.chars);
    my      @key   = (str2num($key) xx $mult)[*;*];     # Flatten the list
    my      @cipher;

    while @plain
    {
        my $m = @plain.shift;
        my $k = @key.shift;

        @cipher.push: ($m + $k) % @ALPHABET.elems;
    }

    return num2str(@cipher);
}

sub decode(Str:D $ciphertext, Str:D $key)
{
    validate('ciphertext', $ciphertext, $key);

    my      @cipher =  str2num($ciphertext);
    my UInt $mult   =  ceiling($ciphertext.chars / $key.chars);
    my      @key    = (str2num($key) xx $mult)[*;*];    # Flatten the list
    my      @plain;

    while @cipher
    {
        my $c = @cipher.shift;
        my $k = @key.shift;

        @plain.push: ($c - $k) % @ALPHABET.elems;
    }

    return num2str(@plain);
}

sub validate(Str:D $name, Str:D $text, Str:D $key)
{
    die "Invalid character '$0' in $name\n" if $text ~~ $NON-ALPHA;
    die "Invalid character '$0' in key\n"   if $key  ~~ $NON-ALPHA;
}

sub str2num(Str:D $string)
{
    return $string.split('', :skip-empty).map: { ord($_) - $ORD-BASE };
}

sub num2str(@nums)
{
    return @nums.map( { chr( $_ + $ORD-BASE ) } ).join('');
}

################################################################################
