#!/usr/bin/env perl
# Perl weekly challenge 362
# Task 1:  Echo Chamber
#
# See https://wlmb.github.io/2026/02/23/PWC362/#task-1-echo-chamber
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to repeat each character Cn of the string Sn=C0C1C2 n+1 times.
    FIN
for(@ARGV){
    my $counter=1;
    my $out = join "", map {$_ x $counter++} split "";
    say "$_ -> $out";
}
