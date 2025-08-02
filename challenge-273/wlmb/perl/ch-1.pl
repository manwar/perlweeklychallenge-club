#!/usr/bin/env perl
# Perl weekly challenge 273
# Task 1:  Percentage of Character
#
# See https://wlmb.github.io/2024/06/10/PWC273/#task-1-percentage-of-character
use v5.36;
use experimental "for_list";
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S1 C1 S2 W2...
    to find the percentage of character Ci in string Si.
    FIN
for my ($str, $chr)(@ARGV){
    my $length=length $str;
    my $matches=0+grep{ lc($_) eq lc($chr)} split "", $str;
    my $percentage = int(.5+100*$matches/$length);
    say "str=$str, chr=$chr -> $percentage";
}
