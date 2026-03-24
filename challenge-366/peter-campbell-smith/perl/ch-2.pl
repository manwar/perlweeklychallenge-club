#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-23
use utf8;     # Week 366 - task 2 - Valid times
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

valid_times('??:??');
valid_times('12:34');
valid_times('?2:34');
valid_times('1?:34');
valid_times('12:?4');
valid_times('12:3?');
valid_times('?7:00');
valid_times('24:00');

sub valid_times {
	
	my ($time, @d, $output, $hrs, $check);
	
	# initialise
	$time = $_[0];
	say qq[\nInput:  '$time'];
	
	# validate
	$check = $time;
	$check =~ s|\?|0|g;
	if ($check !~ m|^(\d\d):(\d\d)$| or $1 > 23 or $2 > 59) {
		say 'Output: invalid time';
		return;
	}
	
	# calculate result - mins
	@d = $time =~ m|^([012\?])([0-9\?]):([0-5\?])([0-9\?])$|;
	$output = 1;
	$output *= 10 if $d[3] eq '?';
	$output *= 6  if $d[2] eq '?';
	
	# and hrs
	$hrs = $d[0] . $d[1];
	$output *= 2  if $hrs =~ m|\?[4-9]|;
	$output *= 3  if $hrs =~ m|\?[0-3]|;
	$output *= 4  if $hrs =~ m|2\?|;
	$output *= 10 if $hrs =~ m|[01]\?|;
	$output *= 24 if $hrs =~ m|\?\?|;
	
	say qq[Output: $output];
}
