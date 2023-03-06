#!/usr/bin/perl

# Challenge 206
#
# Task 1: Shortest Time
# Submitted by: Mohammad S Anwar
#
# You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
#
# Write a script to find out the shortest time in minutes between any two time points.
# Example 1
#
# Input: @time = ("00:00", "23:55", "20:00")
# Output: 5
#
# Since the difference between "00:00" and "23:55" is the shortest (5 minutes).
#
# Example 2
#
# Input: @array = ("01:01", "00:50", "00:57")
# Output: 4
#
# Example 3
#
# Input: @array = ("10:10", "09:30", "09:00", "09:55")
# Output: 15

use Modern::Perl;

@ARGV >= 2 or die "usage: ch-1.pl times...\n";
my @in = sort { $a <=> $b } map { minutes($_) } @ARGV;
push @in, $in[0] + minutes("24:00");
my $min = $in[-1] - $in[0];
for my $i (0..$#in-1) {
    my $n = $in[$i+1] - $in[$i];
    $min = $n if $n < $min;
}
say $min;

sub minutes {
    my($t) = @_;
    $t =~ /^(\d+):(\d+)$/ or die "invalid time $t\n";
    return $1*60+$2;
}
