#!/usr/bin/env perl
# Perl weekly challenge 280
# Task 1:  Twice Appearance
#
# See https://wlmb.github.io/2024/07/29/PWC280/#task-1-twice-appearance
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to print the first duplicated letter in the strings S1 S2...
    FIN
for(@ARGV){
    my %count;
    warn("Expected lower case letters only: $_"), next unless /^[a-z]*$/;
    print "$_ -> ";
    for(split ""){
	say($_),last if ++$count{$_}==2;
    }
}
