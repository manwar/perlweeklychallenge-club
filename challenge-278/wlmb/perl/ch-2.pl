#!/usr/bin/env perl
# Perl weekly challenge 278
# Task 2:  Reverse Word
#
# See https://wlmb.github.io/2024/07/15/PWC278/#task-2-reverse-word
use v5.36;
use experimental qw(for_list);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S1 C1 S2 C2...
    to sort the characters of each string Si upto the character Ci
    FIN
for my($string, $char)(@ARGV){
    warn "Expected a single character: $char" unless length $char == 1;
    my $out=$string =~ /^(.*?$char)(.*)$/
	? join("", sort{$a cmp $b} split "", $1) . $2
        : $string;
    say "$string $char -> $out"
}
