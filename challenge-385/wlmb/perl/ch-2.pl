#!/usr/bin/env perl
# Perl weekly challenge 385
# Task 2:  Outermost Parentheses
#
# See https://wlmb.github.io/2026/08/03/PWC385/#task-2-outermost-parentheses
use v5.36;
use Text::Balanced qw(extract_bracketed);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to extract the string Sn after removing the
    outermost parentheses of every primitive string in the
    primitive decomposition of the given string.
    FIN
for(@ARGV){
    my $remaining=$_;
    my ($extracted, $before);
    my $out="";
    while(1){
	($extracted, $remaining, $before)=extract_bracketed($remaining,"()", "[^\(]*");
	if(!defined $extracted){
	    $out.="(", next if $remaining=~s/^\(//;
	    $out.=$remaining;
	    last;
	}
	$extracted=~s/^\(|\)$//g;
	$out.="$before$extracted";
    }
    say "'$_' -> \"$out\"";
}
