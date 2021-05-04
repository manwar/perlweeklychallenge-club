#!/usr/bin/env perl
# Perl weekly challenge 111
# Task 1: Search matrix
#
# See https://wlmb.github.io/2021/05/03/PWC111/#task-1-search-matrix
use strict;
use warnings;
use v5.12;
use POSIX qw(floor);
# Input matrix from STDIN (not ARGV) as space and newline separated columns and rows.
# Assume it is ordered as stated above
my @elements= map {chomp; (split ' ')} <STDIN>; # no need for organizing in rows
say "Input: $_ Output: ", binary_search($_, @elements) foreach @ARGV;

sub binary_search { # binary search an ordered list
    my $number=shift @_;
    my @array=@_;
    return 0 if $number<$array[0] or $number > $array[-1]; # trivial case
    my $low=0;
    my $high=@array; #beyond highest number
    while($low<$high){
	my $mid=floor(($low+$high)/2);
	return 1     if $array[$mid]==$number;
	return 0     if $mid==$low;
	$low=$mid    if $number > $array[$mid];
	$high=$mid   if $number < $array[$mid];
    }
    return 0;
}
