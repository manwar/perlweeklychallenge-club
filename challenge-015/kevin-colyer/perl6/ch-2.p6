#!/usr/bin/perl6
use v6;

use Test;

# 15.2
# Write a script to implement Vigenère cipher. The script should be able encode and decode. https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher

#| Encodes or Decodes a text using Vigenère cipher.
multi sub MAIN(Str $text , Str $key, Bool :$encode=True, Bool :$decode=False) {

    die "key needs to be smaller or equal to text" unless $text.chars > 0 and $key.chars > 0 and $key.chars <= $text.chars;
    die "key [$key] must be ASCII"   unless $key ~~ m:i /^ <[A..Z]>+ $/;
    die "text [$text] must be ASCII" unless $text ~~ m:i /^ <[A..Z]>+ $/;
    my $which=$encode && ! $decode;

    say VigenereCipher($text,$key,$which);
};

multi sub MAIN(Bool :$test=False) {
    say $*USAGE and exit() unless $test==True;

    say "Testing";
    my $plaintext  = "ATTACKATDAWN";
    my $key        = "LEMONLEMONLE";
    my $ciphertext = "LXFOPVEFRNHR";
    is VigenereCipher($plaintext,$key,True),  $ciphertext,"VigenereCipher encrypts ok";
    is VigenereCipher($ciphertext,$key,False),$plaintext ,"VigenereCipher decrypts ok";
    done-testing;
}

sub VigenereCipher($text,$key,$encode) {
    my $offset="A".ord;
    my @t = $text.uc.comb.map(*.ord-$offset);
    my @k = $key .uc.comb.map(*.ord-$offset);
    my @result;
    my $EorD = $encode==True ?? 1 !! -1;

    my $i=0;

    for ^@t -> $j {
        @result.push: chr($offset + ( (@t[$j]+ $EorD*@k[$i]) mod 26) );
        $i=($i+1) mod @k.elems;

    }
    return @result.join ;
}

