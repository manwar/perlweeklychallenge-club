#!/usr/bin/env perl
# Perl weekly challenge 372
# Task 1:  Rearrange Spaces
#
# See https://wlmb.github.io/2026/05/04/PWC372/#task-1-rearrange-spaces
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to rearrange the spaces in string Sn leaving equal gaps
    between words.
    FIN
for(@ARGV){
    my $input = $_;
    my @words = split" ";
    my $length = 0;
    $length += length $1 while s/(\s+)//;
    my ($spaces, $rest) = @words > 1
       ? ($length / (@words-1), $length % (@words-1))
       : (0,$length);
    my $sep = " " x $spaces;
    say "\"$input\" -> \"", join($sep, @words), " "x$rest, "\"";
}
