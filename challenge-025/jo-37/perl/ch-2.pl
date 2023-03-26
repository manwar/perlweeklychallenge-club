#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental qw(signatures postderef);

our ($plain, $cipher, $decrypt);

die <<EOS unless $plain && $cipher && @ARGV == 1;
usage: $0 -plain=PLAIN -cipher=CIPHER [-decrypt] TEXT

-plain=PLAIN
    use PLAIN as the plain alphabet
 
-cipher=CIPHER
    use CIPHER as the cipher alphabet

-decrypt
    decrypt TEXT

TEXT
    en- or decrypt TEXT

EOS


### Input and Output

say chaocipher($plain, $cipher, shift, $decrypt);


### Implementation

sub chaocipher ($plain, $cipher, $text, $decrypt) {
	my @keys = ([split //, $plain],
                [split //, $cipher]);

    my $result;
    while ($text) {
        my $char = substr $text, 0, 1, '';
        my $ind;
        for ($ind = 0; $keys[!!$decrypt][$ind] ne $char; $ind++) {}
        $result .= $keys[!$decrypt][$ind];
        $keys[0] = [($keys[0]->@[$ind + 1 .. 25, 0 .. $ind])[0, 1, 3 .. 13, 2, 14 .. 25]];
        $keys[1] = [($keys[1]->@[$ind .. 25, 0 .. $ind - 1])[0, 2 .. 13, 1, 14 .. 25]];

    }
    $result;
}
