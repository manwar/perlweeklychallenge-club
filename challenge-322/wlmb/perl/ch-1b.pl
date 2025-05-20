#!/usr/bin/env perl
# Perl weekly challenge 322
# Task 1:  String Format
#
# See https://wlmb.github.io/2025/05/19/PWC322/#task-1-string-format
use v5.36;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S1 I1 S2 I2...
    to edit string Sn making dashed joined substrings of size In
    ignoring any dashes in the original string.
    FIN
for my($string, $size)(@ARGV){
    my $reversed=reverse $string;  # reverse
    $reversed=~tr/-//d;            # remove all dashes
    $reversed=~s/(.{$size})/$1-/g;    # add a dash every three chars
    $reversed=~s/-$//;             # remove final dash if any
    my $out = reverse $reversed;
    say"$string, size -> $out"
}
