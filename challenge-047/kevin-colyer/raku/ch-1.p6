#!/usr/bin/perl6

use v6;
use Test;

=begin pod

TASK #1
Roman Calculator
Write a script that accepts two roman numbers and operation. It should then perform the operation on the give roman numbers and print the result.

For example,

perl ch-1.pl V + VI
It should print

XI

=end pod

# code from PWC 10

sub fromRoman($rn is copy){
    my @t=["XC" ,  90, "CD" ,  400, "IX" ,  9, "CM" ,  900, "IV"  , 4, "XL"  ,  40,"I" , 1,  "V" ,  5,  "X" ,  10,  "L"  , 50,  "C" ,  100,  "D" ,  500,  "M" ,  1000];
    my  Int $dec=0;
    while $rn.chars {
        for @t -> $n,$d {
            die "Unrecognised character in input [$rn]" if $rn !~~ /^ <[X C D I V L M]> /;
            if $rn.starts-with($n) {
                #say "hit $n -> $d";
                $dec+=$d;
                $rn.=subst( $n, '', :1st);
                last;
            }
        }
    }
    return $dec;
}

sub toRoman($i is copy){
    my @t=[1000 , "M", 900 , "CM", 500 , "D", 400 , "CD", 100 , "C", 90 , "XC", 50 , "L", 40 , "XL", 10 , "X", 9 , "IX", 5 , "V", 4 , "IV", 1 , "I"];
    my $rn;
    return "Error - Negative Value" if $i < 0;
    while $i {
        for @t -> $d,$n {
            if $i-$d>=0 {
                #say "match $i, $d";
                $rn~=$n;
                $i-=$d;
                last;
            }
        }
    }
    return $rn;
}

#| Roman Numberal Calculator - Numeral1 +-/* Numeral2 (/ and * require quoting)
sub MAIN(Str $numeral1, Str $operation, Str $numeral2) {
    my $n1=fromRoman($numeral1);
    my $n2=fromRoman($numeral2);
    given $operation {
        when '+' { toRoman($n1+$n2).say };
        when '-' { toRoman($n1-$n2).say };
        when '*' { toRoman($n1*$n2).say };
        when '/' { toRoman(Int($n1/$n2)).say };
        default { say "Unknown operation '$operation'" }
    }
}
