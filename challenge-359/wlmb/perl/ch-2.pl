#!/usr/bin/env perl
# Perl weekly challenge 359
# Task 2:  String Reduction
#
# See https://wlmb.github.io/2026/02/02/PWC359/#task-2-string-reduction
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to remove adjacent duplicated characters from the strings Sn.
    FIN
for(@ARGV){
    my $in=$_;
    1 while s/(.)\1//g;
    say "$in -> $_";
}
