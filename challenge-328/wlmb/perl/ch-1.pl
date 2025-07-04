#!/usr/bin/env perl
# Perl weekly challenge 328
# Task 1:  Replace all ?
#
# See https://wlmb.github.io/2025/07/03/PWC328/#task-1-replace-all-?

use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to replace ? by lowercase letters in the lowercase strings S1 S2...
    so that no letter repeats.
    FIN
for(@ARGV){
    say "Expected only lowercase letters and ?'s" unless /^[a-z?]+$/;
    say("Expected no repeating letters in string: $_"), next if /([a-z])\1/;
    my $in=$_;
    1 while s/(.?)(\?)(.?)/replace($1, $3)/e;
    say "$in -> $_";
}
sub replace($x, $z){
    my $y="a";
    ++$y while $y eq $x or $y eq $z;
    "$1$y$3"
}
