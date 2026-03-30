#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-30
use utf8;     # Week 367 - task 2 - Conflict events
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

conflict_events('09:00', '12:00', '10:00', '13:00');
conflict_events('09:00', '12:00', '10:00', '11:00');
conflict_events('09:00', '12:00', '08:00', '13:00');
conflict_events('09:00', '12:00', '08:00', '11:00');

conflict_events('22:00', '02:00', '23:00', '03:00');
conflict_events('22:00', '02:00', '23:00', '01:00');
conflict_events('22:00', '02:00', '21:00', '00:00');
conflict_events('22:00', '02:00', '00:00', '03:00');

conflict_events('09:00', '12:00', '12:00', '15:00');
conflict_events('12:00', '15:00', '09:00', '12:00');

sub conflict_events {
	
	my (@events, $e, @times, $overlap_starts, $overlap_ends);
	
	# initialise
	@events = @_;
	say qq[\nInput:  $events[0]-$events[1] and $events[2]-$events[3]];
	
	# convers times to mins past midnight
	for $e (0 .. 3) {
		if ($events[$e] =~ m|(\d\d):(\d\d)|) {
			@times[$e] = $1 * 60 + $2;
		} else {
			say qq[Output: malformed time $events[$e]];
			return;
		}
	}
	
	# if end times precede start times assume the next day
	$times[1] += 1440 if $times[1] < $times[0];
	$times[2] += 1440 if $times[0] - $times[2] >= 720;
	$times[3] += 1440 if $times[3] < $times[2];
	
	# overlap is from the latest start to the earliest finish
	$overlap_starts = $times[0] > $times[2] ? $events[0] : $events[2];
	$overlap_ends = $times[1] > $times[3] ? $events[3] : $events[1];
	
	# report
	if ($times[2] >= $times[1] or $times[0] >= $times[3]) {
		say qq[Output: false - events do not overlap];
	} else {
		say qq[Output: true - events overlap from $overlap_starts until $overlap_ends]; 
	}
}		
