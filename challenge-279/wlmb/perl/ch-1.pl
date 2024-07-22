#!/usr/bin/env perl
# Perl weekly challenge 279
# Task 1:  Sort Letters
#
# See https://wlmb.github.io/2024/07/22/PWC279/#task-1-sort-letters
use v5.36;
use experimental qw(for_list);
use List::Util qw(zip);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S1 N1 S2 N2...
    to sort the characters of string Si according to the space-separated numbers Ni.
    FIN
PAIRS:
for my($chars, $numbers)(@ARGV){
    my @chars = split "", $chars;
    my @numbers = split " ", $numbers;
    warn("Expected one number per char: chars: @chars, numbers: @numbers"), next PAIR
	unless @chars == @numbers;
    for(@numbers){warn("Only digits allowed: $_"), next PAIR unless /^[\d\s]+$/;}
    my @schwartz=zip \@chars, \@numbers;
    my $out = join "", map {$_->[0]} sort {$a->[1] <=> $b->[1] || $a->[0] cmp $b->[0]}
              @schwartz;
    say "chars: $chars, numbers: $numbers -> $out";
}
