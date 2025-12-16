#!/usr/bin/env perl
# Perl weekly challenge 352
# Task 1:  Match String
#
# See https://wlmb.github.io/2025/12/16/PWC352/#task-1-match-string
use v5.36;
use List::Util qw(any uniq);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find space separated strings in Sn that are substrings of others.
    FIN
for(@ARGV){
    my $n=my @in=split " ";
    my @out=();
    for(0..@in-1){
	my $current=$in[my $current_indx=$_];
	push @out, $current if any{$current_indx ne $_ && $in[$_]=~/$current/} 0..@in-1;
    }
    say "$_ -> ", join " ", uniq @out;
}
