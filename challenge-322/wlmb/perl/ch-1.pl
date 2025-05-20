#!/usr/bin/env perl
# Perl weekly challenge 322
# Task 1:  String Format
#
# See https://wlmb.github.io/2025/05/19/PWC322/#task-1-string-format
use v5.36;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S1 I1 S2 I2...
    to edit string Sn making dahsed joined substrings of size not larger than In
    by removing dashes from the original string.
    FIN
for my($string, $size)(@ARGV){
    my $processing="";
    my @edited;
    for(reverse split "-",$string){
        unshift(@edited, $processing), $processing="" if(length($processing)+length)>$size;
        $processing = $_.$processing;
    }
    say "$string, $size -> ", join "-", $processing, @edited;
}
