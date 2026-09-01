#!/usr/bin/env perl
# Perl weekly challenge 389
# Task 2:  ZigZag Subarray
#
# See https://wlmb.github.io/2026/08/31/PWC389/#task-2-zigzag-subarray
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the longest zigzag subsequence of the space separated
    sequence Si="N0 N1..." where Nj are numbers.
    FIN

for(@ARGV){
    my ($current, @rest)=split" ";
    my @signs;
    while(@rest){
	push(@signs, $current <=> (my $next = shift @rest));
	$current = $next;
    }
    $signs[2*$_] *= -1 for 0..(@signs-1)/2;
    my @lengths;
    while(@signs){
	my $count = 1;
	my $first_sign = shift @signs;
	++$count if $first_sign;
	++$count, shift @signs while @signs && $signs[0]*$first_sign==1;
	push @lengths, $count;
    }
    say "$_ -> ", max @lengths;
}
