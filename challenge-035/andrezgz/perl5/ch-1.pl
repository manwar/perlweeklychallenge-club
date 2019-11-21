#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-035/
# Task #1
# Write a program to encode text into binary encoded morse code.
# Pay attention to any changes which might need to be made to the text to make it valid morse code.
#
# Morse code consists of dots, dashes and gaps. It can be encoded in binary in the following fashion:
# https://en.wikipedia.org/wiki/Morse_code
#
# dot: 1
# dash: 111
# intra-character gap: 0
# character gap: 000
# word gap: 0000000
# An intra-character gap is inserted between the dots and dashes in a character.

use strict;
use warnings;

my %morse = (
    A => '.-',      N => '-.',
    B => '-...',    O => '---',
    C => '-.-.',    P => '.--.',
    D => '-..',     Q => '--.-',
    E => '.',       R => '.-.',
    F => '..-.',    S => '...',
    G => '--.',     T => '-',
    H => '....',    U => '..-',
    I => '..',      V => '...-',
    J => '.---',    W => '.--',
    K => '-.-',     X => '-..-',
    L => '.-..',    Y => '-.--',
    M => '--',      Z => '--..',

    0 => '-----',   5 => '.....',
    1 => '.----',   6 => '-....',
    2 => '..---',   7 => '--...',
    3 => '...--',   8 => '---..',
    4 => '....-',   9 => '----.',
);

my %morse_bin = (
    '.'     => '1',         # dot
    '-'     => '111',       # dash
    'i-gap' => '0',         # intra-character gap
    'c-gap' => '000',       # character gap
    'w-gap' => '0000000',   # word gap
);

die "Usage: $0 <space separated words>" unless @ARGV;

my $wgap = 0;

print   $wgap++ ? $morse_bin{'w-gap'} : '',
        join $morse_bin{'c-gap'},
        map {
            join $morse_bin{'i-gap'},
            map { $morse_bin{$_} }
            split //;
        }
        map { $morse{uc $_} }
        split //
        foreach (@ARGV);

__END__

./ch-1.pl JUST ANOTHER PERL HACKER
101110111011100010101110001010100011100000001011100011101000111011101110001110001010101000100010111010000000101110111010001000101110100010111010100000001010101000101110001110101110100011101011100010001011101

