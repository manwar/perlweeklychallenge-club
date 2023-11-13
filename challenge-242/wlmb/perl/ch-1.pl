#!/usr/bin/env perl
# Perl weekly challenge 242
# Task 1:  Missing Members
#
# See https://wlmb.github.io/2023/11/06/PWC242/#task-1-missing-members
use v5.36;
die <<~"FIN" unless @ARGV==2;
    Usage: $0 S0 S1
    to find the space-separated elements of S0 missing from S1 and viceversa.
    FIN
my @bits=(1,2);
my %bitmasks;
for(0,1){
    my $bit=$bits[$_];
    $bitmasks{$_}|=$bit for split " ", $ARGV[$_];
}
my @results;
for(0,1){
    my $bit=$bits[$_];
    @{$results[$_]}=sort {$a <=> $b} grep{$bitmasks{$_}==$bit}keys %bitmasks;
}
say "[$ARGV[0]],[$ARGV[1]] -> [@{$results[0]}], [@{$results[1]}]";
