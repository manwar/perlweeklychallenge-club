#!/usr/bin/env perl
# Perl weekly challenge 264
# Task 1:  Greatest English Letter
#
# See https://wlmb.github.io/2024/04/12/PWC264/#task-1-greatest-english-letter
use v5.36;
use List::Util qw(maxstr);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    to find the greatest English letter of each string S1, S2...
    FIN
for(@ARGV){
    warn("Only alphabetical characters allowed a..z A..Z"), next unless /^[a-zA-Z]+$/;
    my %seen;
    $seen{$_}++ for split "";
    say "$_ -> ",  maxstr grep {$_ eq uc && $seen{lc $_}}keys %seen;
}
