#!/usr/bin/env perl
# Perl weekly challenge 308
# Task 1:  Count Common
#
# See https://wlmb.github.io/2025/02/10/PWC308/#task-1-count-common
use v5.36;
die <<~"FIN" unless  @ARGV==2;
    Usage $0 S1 S2
    to find how many words are common to the
    space separated strings S1 and S2
    FIN
my @seen;
for my $x(0,1){
    ++$seen[$x]{$_}for split" ",$ARGV[$x];
}
say "s1 = $ARGV[0], s2=$ARGV[1] -> ", 0+grep{$seen[0]{$_}} keys %{$seen[1]};
