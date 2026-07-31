#!/usr/bin/env perl
# Perl weekly challenge 384
# Task 2:  Special Binary Substrings
#
# See https://wlmb.github.io/2026/07/27/PWC384/#task-2-special-binary-substrings
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to look for substrings of Sn of the form
    00...11... or 11...00... with the same number of
    consecutive ones and zeroes.
    FIN
for(@ARGV){
    my $string=$_;
    my $length=length($string)/2;
    say"$_ -> (",(
        join " ",
        map {
            $string=~/(0{$_}1{$_})/,
            $string=~/(1{$_}0{$_})/
        } 1..$length
        ), ")";
}
