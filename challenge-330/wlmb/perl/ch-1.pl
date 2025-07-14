#!/usr/bin/env perl
# Perl weekly challenge 330
# Task 1:  Clear Digits
#
# See https://wlmb.github.io/2025/07/14/PWC330/#task-1-clear-digits
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to repeatedly remove digits from the string Sn, together with the closest
    non-digit to its left.
    Only lowercase letters and digits are allowed in the strings.
    FIN
for(@ARGV){
    my $input=$_;
    say("Only digits and lowercase letters allowed: $input"), next
	unless /^[a-z0-9]*$/;
    1 while s/[a-z][0-9]//;  #strip all letter-digit pairs
    say("Couldn't strip all digits: $input -> $_"), next if /[0-9]/;
    say "$input -> $_";
}
