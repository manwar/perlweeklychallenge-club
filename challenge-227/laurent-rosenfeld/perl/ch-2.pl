#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my %rom_tab = (I => 1,  V => 5, X => 10, L => 50,
               C => 100, D => 500, M => 1000,
               IV => 4, IX => 9,  XL => 40, XC => 90,
               CD => 400,  CM => 900);

sub from_roman {
    my $roman = uc shift;
    my $arabic = 0;
    my $prev_letter = "M";
    for my $letter (split //, $roman) {
        $arabic -= 2 * $rom_tab{$prev_letter}
            if $rom_tab{$letter} > $rom_tab{$prev_letter};
        $arabic += $rom_tab{$letter};
        $prev_letter = $letter;
    }
    return $arabic;
}

sub to_roman {
    my $arabic = shift;
    warn "$arabic out of bounds"
        unless $arabic > 0 and $arabic < 4000;
    my $roman = "";
    for my $key (sort { $rom_tab{$b} <=> $rom_tab{$a} }
        keys %rom_tab) {
        my $num = int ($arabic / $rom_tab{$key});
        $roman .= $key x $num;
        $arabic -= $rom_tab{$key} * $num;
    }
    return $roman;
}
sub process_input {
    my ($rom1, $op, $rom2) = split /\s+/, $_[0];
    my $arabic1 = from_roman $rom1;
    my $arabic2 = from_roman $rom2;
    my $result = $op eq '+'  ?  $arabic1 + $arabic2 :
                 $op eq '-'  ?  $arabic1 - $arabic2 :
                 $op eq '/'  ?  $arabic1 / $arabic2 :
                 $op eq '*'  ?  $arabic1 * $arabic2 :
                 $op eq '**' ?  $arabic1 ** $arabic2:
                 "illegal";
    return "nulla (they didn't have a symbol for 0)"
        if $result == 0;
    return "non potest (they didn't do fractions)"
        if int($result) != $result;
    return "non potest (they only went up to 3999)"
        if $result >= 4000;
    return "non potest (no negative numbers)"
        if $result < 0;
    return to_roman $result;
}

for my $test ("IV + V", "M - I", "X / II", "XI * VI",
              "VII ** III", "V - V", "V / II", "MMM + M",
              "V - X ", "X - V") {
    printf "%-10s => ", $test;
    say process_input $test;
}
