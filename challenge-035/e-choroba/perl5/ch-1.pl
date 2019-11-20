#!/usr/bin/perl
use warnings;
use strict;

my %to_morse = qw( a .-   b -... c -.-. d -..  e .    f ..-. g --.  h ....
                   i ..   j .--- k -.-  l .-.. m --   n -.   o ---  p .--.
                   q --.- r .-.  s ...  t -    u ..-  v ...- w .--  x -..-
                   y -.-- z --.. );
my %from_morse = ('/' => "", '//' => ' ', reverse %to_morse);

my %to_binary = ('.'  => 1,
                 '-'  => 111,
                 ""   => 0,
                 '/'  => '000',
                 '//' => '0000000');
my %from_binary = reverse %to_binary;

sub encode_to_morse {
    join('/', map $to_morse{$_} // "", split //, shift)
}

sub encode_to_binary_digits {
    encode_to_morse(shift) =~ s,((?<=[-.])(?=[-.])|//?|[-.]),$to_binary{$1},gr
}

sub encode_to_binary {
    pack 'b*', encode_to_binary_digits(shift)
}

sub decode_to_binary_digits {
    unpack('b*', shift) =~ s/0*$//r
}

sub decode_to_morse {
    join "",
         map $from_binary{$_},
         split /(0+)/,
         decode_to_binary_digits(shift)
}

sub decode_from_binary {
    join "", map $from_morse{$_}, split m{(/+)}, decode_to_morse(shift)
}

use Test::More tests => 6;

my $input = 'just another';
my $morse = '.---/..-/.../-//.-/-./---/-/...././.-.';
my $digits = '101110111011100010101110001010100011100000001011100'
           . '01110100011101110111000111000101010100010001011101';
my $bin    = join "", map chr,
             221, 29, 117, 84, 28, 208, 113, 113, 119, 28, 85, 68, 23;

is encode_to_morse('just another'), $morse, 'encode to morse';

is encode_to_binary_digits('just another'), $digits, 'encode to binary digits';

is encode_to_binary('just another'), $bin, 'encode to binary';

is decode_to_binary_digits($bin), $digits, 'decode to binary digits';

is decode_to_morse($bin), $morse, 'decode to morse';

is decode_from_binary($bin), $input, 'decode from binary';
