#!/usr/bin/perl

use strict;
use warnings;

sub encode_roman {
    my $number    = shift;
    my @roman_map = (
        [ 'M',  1000 ],
        [ 'CM', 900 ],
        [ 'D',  500 ],
        [ 'CD', 400 ],
        [ 'C',  100 ],
        [ 'XC', 90 ],
        [ 'L',  50 ],
        [ 'XL', 40 ],
        [ 'X',  10 ],
        [ 'IX', 9 ],
        [ 'V',  5 ],
        [ 'IV', 4 ],
        [ 'I',  1 ]
    );
    my $roman_numeral = '';
    foreach my $pair (@roman_map) {
        my ( $numeral, $value ) = @$pair;
        while ( $number >= $value ) {
            $roman_numeral .= $numeral;
            $number -= $value;
        }
    }
    return $roman_numeral;
}

sub decode_roman {
    my $roman_numeral = shift;
    my @roman_map     = (
        [ 'M',  1000 ],
        [ 'CM', 900 ],
        [ 'D',  500 ],
        [ 'CD', 400 ],
        [ 'C',  100 ],
        [ 'XC', 90 ],
        [ 'L',  50 ],
        [ 'XL', 40 ],
        [ 'X',  10 ],
        [ 'IX', 9 ],
        [ 'V',  5 ],
        [ 'IV', 4 ],
        [ 'I',  1 ]
    );
    my $number = 0;
    foreach my $pair (@roman_map) {
        my ( $numeral, $value ) = @$pair;
        while ( $roman_numeral =~ /^$numeral/ ) {
            $number += $value;
            $roman_numeral =~ s/^$numeral//;
        }
    }
    return $number;
}

# Test the functions
my $roman_numeral = 'CCXLVI';
my $number        = decode_roman($roman_numeral);
print "$roman_numeral = $number\n";
my $shortest_numeral = encode_roman($number);
print "$number = $shortest_numeral\n";

my $decimal_number = 39;
$roman_numeral = encode_roman($decimal_number);
print "$decimal_number = $roman_numeral\n";
$number = decode_roman($roman_numeral);
print "$roman_numeral = $number\n";
