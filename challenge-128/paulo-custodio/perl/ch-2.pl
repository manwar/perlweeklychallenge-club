#!/usr/bin/env perl

# TASK #2 > Minimum Platforms
# Submitted by: Mohammad S Anwar
# You are given two arrays of arrival and departure times of trains at a railway
# station.
#
# Write a script to find out the minimum number of platforms needed so that no
# train needs to wait.
#
# Example 1:
# Input: @arrivals   = (11:20, 14:30)
#        @departures = (11:50, 15:00)
# Output: 1
#
#     The 1st arrival of train is at 11:20 and this is the only train at the
#     station, so you need 1 platform.
#     Before the second arrival at 14:30, the first train left the station at
#     11:50, so you still need only 1 platform.
# Example 2:
# Input: @arrivals   = (10:20, 11:00, 11:10, 12:20, 16:20, 19:00)
#        @departures = (10:30, 13:20, 12:40, 12:50, 20:20, 21:20)
# Output: 3
#
#     Between 12:20 and 12:40, there would be at least 3 trains at the station,
#     so we need minimum 3 platforms.

use Modern::Perl;
use Time::Piece;

my @stops = parse_arrivals_departures();
my @platforms = allocate_platforms(@stops);
say scalar(@platforms);

sub parse_arrivals_departures {
	my @arrivals = parse_times();
	my @departures = parse_times();
	
	my @stops;
	while (@arrivals && @departures) {
		push @stops, [shift @arrivals, shift @departures];
	}
	return @stops;
}

sub parse_times {
	my @times = map {Time::Piece->strptime($_, "%H:%M")->epoch} 
				split(' ', scalar(<>));
}

sub allocate_platforms {
	my(@stops) = @_;
	my @platforms;
	
	for my $stop (@stops) {
		allocate_stop(\@platforms, @$stop);
	}
	return @platforms;
}

sub allocate_stop {
	my($platforms, $s, $e) = @_;
	for my $p (0 .. $#$platforms) {
		if (platform_free($platforms->[$p], $s, $e)) {
			push @{$platforms->[$p]}, [$s, $e];
			return;
		}
	}
	push @$platforms, [[$s, $e]];
}

sub platform_free {
	my($platform, $s, $e) = @_;
	for my $stop (@$platform) {
		if (($s >= $stop->[0] && $s <  $stop->[1]) ||
		    ($e >= $stop->[0] && $e <  $stop->[1]) ||
			($s <  $stop->[0] && $e >= $stop->[1])) {
			return 0;
		}
	}
	return 1;
}
