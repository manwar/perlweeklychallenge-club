#!/usr/bin/env perl
# Perl weekly challenge 396
# Task 2:  Trionic Array
#
# See https://wlmb.github.io/2026/10/19/PWC396/#task-2-trionic-array
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 L0 L1...
    to find if the space separated list Ln is trionic,
    i.e., strictly increasing, decreasing and then increasing.
    FIN
for(@ARGV){
    my @arr = split " ";
    my ($increasing, $decreasing, $failed) = (0, 0, 0);
    for(1..@arr-1){
	my $sign = $arr[$_-1] <=> $arr[$_];
	$failed=1,last
	    if (!$sign                           # not strictly increasing or decreasing
		|| $increasing==0 && $sign > 0   # decreasing before increasing
		|| $increasing==2 && $sign > 0); # decreasing after increasing twice
	$increasing = 1,next
	    if $decreasing == 0 && $sign < 0;    # first increasing
	$decreasing = 1,next
	    if $increasing==1 && $sign > 0;      # first decreasing
	$increasing = 2, next
	    if $decreasing == 1 && $sign<0;      # second increasing
    }
    say "$_ -> ", ($failed || $increasing < 2)?"False":"True";
}
