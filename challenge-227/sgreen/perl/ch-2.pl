#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub from_roman($roman) {
    my @romans = split //, $roman;
    my %mapping = ( I => 1, V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000);
    my @digits = map { $mapping{$_} } @romans;

    my $number = 0;
    while (my ($i, $v) = each @digits) {
        if ($i < $#digits and $v < $digits[$i+1]) {
            $number -= $v;
        }
        else {
            $number += $v;
        }}

    return $number;}

sub to_roman($number) {
    if ($number == 0) {
        return 'nulla';
    }
    elsif ($number > 3999 or $number < 0) {
        return 'non potest';
    }
    elsif (index($number, '.') != -1) {
        if ($number != int($number)) {
            return 'non potest';
        }
        $number = int($number);
    }

    my @mapping = (
        [ '', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', ],
        [ '', 'X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC', ],
        [ '', 'C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM', ],
        [ '', 'M', 'MM', 'MMM', ],
    );

    my $roman = '';
    my @digits = reverse(split //, $number);

    # Iterate in reverse
    while (my ($i, $d) = each @digits) {
        $roman = $mapping[$i][$d] . $roman;
    }

    return $roman;
}

sub main($roman1, $oper, $roman2) {
    my $number1 = from_roman($roman1);
    my $number2 = from_roman($roman2);
    my $number = 0;

    if ($oper eq '+') {
        $number = $number1 + $number2;
    }
    elsif ($oper eq '-') {
        $number = $number1 - $number2;
    }
    elsif ($oper eq '*' or $oper eq '×') {
        $number = $number1 * $number2;
    }
    elsif ($oper eq '/' or $oper eq '÷') {
        $number = $number1 / $number2;
    }
    elsif ($oper eq '**') {
        $number = $number1 ** $number2;
    }
    else {
        die "Unknown operator: '$oper'\n";
    }

    say to_roman($number);
}

main(@ARGV);