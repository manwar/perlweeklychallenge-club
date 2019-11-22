#!/usr/bin/env per
# Author: Steven Wilson
# Date: 2019-11-18
# Week: 035
# Task #1
# Contributed by Paul Johnson
# Write a program to encode text into binary encoded morse code.
# Pay attention to any changes which might need to be made to the text
# to make it valid morse code.
# Morse code consists of dots, dashes and gaps. It can be encoded in
# binary in the following fashion:
# dot: 1
# dash: 111
# intra-character gap: 0
# character gap: 000
# word gap: 0000000
# An intra-character gap is inserted between the dots and dashes in a
# character.

use strict;
use warnings;
use feature qw/ say /;
use Test::More tests => 2;

my %binary_morse_code = (
    A => "10111",
    B => "111010101",
    C => "11101011101",
    D => "1110101",
    E => "1",
    F => "101011101",
    G => "111011101",
    H => "1010101",
    I => "101",
    J => "1011101110111",
    K => "111010111",
    L => "101110101",
    M => "1110111",
    N => "11101",
    O => "11101110111",
    P => "10111011101",
    Q => "1110111010111",
    R => "1011101",
    S => "10101",
    T => "111",
    U => "1010111",
    V => "101010111",
    W => "101110111",
    X => "11101010111",
    Y => "1110101110111",
    Z => "11101110101",
    1 => "10111011101110111",
    2 => "101011101110111",
    3 => "1010101110111",
    4 => "10101010111",
    5 => "101010101",
    6 => "11101010101",
    7 => "1110111010101",
    8 => "111011101110101",
    9 => "11101110111011101",
    0 => "1110111011101110111",
);

my $test_string = " ,,,//@ eg# test 1. ";
ok( text_to_binary_morse_code("SOS") eq "101010001110111011100010101",
    "Test SOS" );
ok( text_to_binary_morse_code($test_string) eq
        "10001110111010000000111000100010101000111000000010111011101110111",
    "Test illegal chars and white space"
);

sub text_to_binary_morse_code {
    my $input = uc shift;
    $input =~ s/[^[:alnum:] ]//g;    #only alphanumeric and white space
    $input =~ s/^\s+|\s+$//g;        #trim both ends
    $input =~ s/\s+/ /g;             #squish white space
    my @characters = split //, $input;
    my @result;
    for ( my $i = 0; $i < ( length $input ); $i++ ) {
        if ( $characters[$i] eq " " ) {
            push @result, "0000000";
        }
        elsif ( exists $characters[ $i + 1 ] && $characters[ $i + 1 ] ne " " )
        {
            push @result, $binary_morse_code{ $characters[$i] } . "000";
        }
        else {
            push @result, $binary_morse_code{ $characters[$i] };
        }
    }
    return join "", @result;
}
