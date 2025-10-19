#!/usr/bin/env perl
# Perl weekly challenge 343
# Task 1:  Zero Friend
#
# See https://wlmb.github.io/2025/10/18/PWC343/#task-1-zero-friend
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 A0 A1...
    to find the minimum distance from the elements of the array Ai to zero.
    Each Ai is a string of the form "[x0 x1...]", i.e., space separated
    numbers xi within square brackets.
    FIN
for(@ARGV){
    try{ say "$_ -> ", pdl($_)->abs->min; }
    catch($e){ "warn $e"}
}
