#!/usr/bin/env perl
# Perl weekly challenge 390
# Task 1:  Decode String
#
# See https://wlmb.github.io/2026/09/11/PWC390/#task-1-decode-string
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 E0 E1...
    to decode the encoded strings En of the form
    A or AN[B]C
    where A is an ordinary string, N a repetition count,
    and B and C encoded strings.
    FIN
for(@ARGV){
    my $in = $_;
    1 while s/
          (\d+)       # number
          \[          # opening bracket
          ([^\[\]]*)  # string without brackets
          \]          # closing bracket
         /$2 x $1/xe; # repeat bracketed string
    say "$in -> $_";
}
