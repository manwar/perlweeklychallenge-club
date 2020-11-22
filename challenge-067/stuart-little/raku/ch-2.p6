#!/usr/bin/env perl6
use v6;

my %trhsh = (
    1 => <_ @>,
    2 => <a b c>,
    3 => <d e f>,
    4 => <g h i>,
    5 => <j k l>,
    6 => <m n o>,
    7 => <p q r s>,
    8 => <t u v>,
    9 => <w x y z>,
);

sub kypd(Str $s where * ~~ /^<[1..9]>+$/) {
    $s.comb.map({ %trhsh.{$_} }).reduce(&infix:<X>).map(*.join)
}

@*ARGS[0].&kypd.say

# run as <script> <digit string>
