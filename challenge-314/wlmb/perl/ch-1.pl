#!/usr/bin/env perl
# Perl weekly challenge 314
# Task 1:  Equal Strings
#
# See https://wlmb.github.io/2025/03/24/PWC314/#task-1-equal-strings
use v5.36;
use List::Util qw(all sum0);
die <<~"FIN" unless @ARGV and @ARGV%3==0;
    Usage: $0 S11 S12 S13 S21 S22 S23...
    to find how many times the strings Sn1 Sn2 Sn3 have to be cut
    from their end so they become equal.
    FIN
for my ($x, $y, $z)(@ARGV){
    my @orig = my @strings = ($x, $y, $z);
    my $iterations = 0;
    while(all {my $p=substr $strings[0],0,1; /^$p/} @strings){ # if first characters coincide
	++$iterations;
	s/^.(.*)/$1/ for @strings;                     # remove them
    }
    say "@orig -> ", $iterations ? sum0 map {length} @strings : -1;
}
