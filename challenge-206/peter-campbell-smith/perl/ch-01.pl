#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-20

use v5.28;
use utf8;
use warnings;

# Task: You are given a list of time points, at least 2, in the 24-hour clock format HH:MM. Write a script 
# to find out the shortest time in minutes between any two time points.

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/206/1

my (@time, $j);

shortest_interval("00:01", "01:05", "01:12", "23:59");
shortest_interval("01:01", "00:50", "00:57");
shortest_interval("10:10", "09:30", "09:00", "09:55");
shortest_interval("08:59", "21:00");
shortest_interval("09:01", "21:00");

for $j (0 .. 20) {
	@time[$j] = sprintf('%02d:%02d', rand(24), rand(60));
}
shortest_interval(@time);

sub shortest_interval {
	
	my (@times, $minutes, $shortest, $j, $gap, $this_minutes);
	
	# sort the times so that the shortest gap is bewteen 2 consecutive entries
	@times = sort @_;
	
	# add one to the end that is 24hr after the first, in case the shortest bridges midnight
	$times[0] =~ m|^(\d\d).(\d\d)|;
	$times[scalar(@times)] = sprintf('%02d:%02d', $1 + 24, $2);
	$minutes = $1 * 60 + $2;
	
	# pass along the list comparing each element with the previous one
	$shortest = 9999;
	for $j (1 .. scalar(@times) - 1) {
		$times[$j] =~ m|^(\d\d).(\d\d)|;
		$this_minutes = $1 * 60 + $2;
		$gap = $this_minutes - $minutes;
		$shortest = $gap if $gap < $shortest;
		last if $shortest == 0;
		$minutes = $this_minutes;
	}
	
	say qq[\nInput:  \@time = ("] . join('", "', @_) . qq[")\nOutput: $shortest];
}
	
	

