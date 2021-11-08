#!/usr/bin/perl
# 
# Task 2: "Minimum Platforms
# 
# You are given two arrays of arrival and departure times of trains at a
# railway station.
# 
# Write a script to find out the minimum number of platforms needed so
# that no train needs to wait.
# 
# Example 1:
# 
# Input: @arrivals   = (11:20, 14:30)
#        @departures = (11:50, 15:00)
# Output: 1
# 
# The 1st arrival of train is at 11:20 and this is the only train at the
# station, so you need 1 platform.  Before the second arrival at 14:30, the
# first train left the station at 11:50, so you still need only 1 platform.
# 
# Example 2:
# 
# Input: @arrivals   = (10:20, 11:00, 11:10, 12:20, 16:20, 19:00)
#        @departures = (10:30, 13:20, 12:40, 12:50, 20:20, 21:20)
# Output: 3
# 
# Between 12:20 and 12:40, there would be at least 3 trains at the station,
# so we need minimum 3 platforms."
# 
# My notes: nice problem - looks like a tiny discrete event simulation.
# Build a DIARY: an array of (time, type) pairs - where type == 'A' for
# an arrival, or type == 'D' for a departure.  Then walk the diary,
# simulating "train arrival" and "train departure" events.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;

die "Usage: platforms [-d|--debug] list(arrive,depart) pairs\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>0;
my @diary = make_diary( @ARGV );
#die Dumper \@diary;

# do the simulation - walk over the diary, counting
# the number of trains at any one point

my $ntrains = 0;
my $max_ntrains = 0;
foreach my $dp (@diary)
{
	my( $t, $type ) = @$dp;
	say "debug: t=$t, type=$type" if $debug;
	if( $type eq "A" )
	{
		$ntrains++;
		if( $ntrains > $max_ntrains )
		{
			$max_ntrains = $ntrains;
			say "debug @ $t: max ntrains=$max_ntrains" if $debug;
		}
	} else
	{
		$ntrains--;
	}
}

say $max_ntrains;



#
# my $t = parsetime($hhmm);
#	Take $hhmm, an hh:mm time string, and compute an integer minutes
#	date; return that.
#
fun parsetime( $hhmm )
{
	$hhmm =~ /^(\d\d):(\d\d)$/;
	return 60*$1 + $2;
}


#
# my @diary = make_diary( @ad );
#	Parse and construct a diary (array of [HHMM,TYPE] pairs)
#	from the arrival,departure pairs in @ad.  Return the diary.
#
my %hhmm2t;
fun make_diary( @ad )
{
	my @diary;
	foreach my $ad (@ad)
	{
		my( $a, $d ) = split( /,/, $ad );
		$hhmm2t{$a} = parsetime($a);
		$hhmm2t{$d} = parsetime($d);
		push @diary, [ $a, 'A' ];
		push @diary, [ $d, 'D' ];
	}
	#die Dumper \@diary;
	#die Dumper \%hhmm2t;
	return sort { my $at = $a->[0]; my $bt = $b->[0];
		      #say "debug: at=$at, hm{$at}=$hhmm2t{$at}, bt=$bt, hm{$bt}=$hhmm2t{$bt}";
		      $hhmm2t{$at} <=> $hhmm2t{$bt} }
		      @diary;
}
