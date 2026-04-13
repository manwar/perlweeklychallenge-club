#!/usr/bin/env perl
# Perl weekly challenge 369
# Task 2:  Group Division
#
# See https://wlmb.github.io/2026/04/13/PWC369/#task-2-group-division
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%3==0;
    Usage: $0 S0 L0 F0 S1 L1 F1...
    to divide the string Ln into pieces of length Ln
    filling the last one with the filler Fn.
    FIN
for my($string, $size, $filler)(@ARGV){
    warn("Filler must be one character wide: $filler"), next
	unless length $filler==1;
    my @result = $string =~ /(.{$size}|.+)/g;
    $result[-1] .= "$filler" x ($size - length $result[-1]);
    say "string=$string, size=$size, filler=$filler -> ",
	join ", ", map {"\"$_\""} @result;
}
