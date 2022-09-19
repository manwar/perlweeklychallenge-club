#!/usr/bin/perl
# 
# Task 2: Business Date
#
# You are given $timestamp (date with time) and $duration in hours.
# 
# Write a script to find the time that occurs $duration business hours
# after $timestamp. For the sake of this task, let us assume the working
# hours is 9am to 6pm, Monday to Friday. Please ignore timezone too.
# 
# For example,
# 
# Suppose the given timestamp is 2022-08-01 10:30 and the duration is 4 hours:
# then the next business date would be 2022-08-01 14:30.
# 
# Similar if the given timestamp is 2022-08-01 17:00 and the duration
# is 3.5 hours, then the next business date would be 2022-08-02 11:30.
# 
# MY NOTES: ok, this is relatively straightforward.  We have to "wrap
# around" from date D, time 18:00 to date D+1 time 09:00 (when D is
# Mon..Thur), and similarly wrap around from Friday 18:00 to the following
# Monday 09:00..
#
# My first version (ch-2.pl) shows how to cheat using Date::Manip, which
# already has a concept of business days which does of the work.
#
# This version (ch-2a.pl) shows an alternative where we do most of the
# work ourselves, needing only routines to:
#   - parse a calendar date and time, and
#   - move to the next calendar date, and
#   - determine which day of the week (Mon..Sun, 1..7) a date is
#   - break a date down into (year, month, day, hour, minutes)

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Date::Manip::Date;
use Date::Manip::Delta;
use Function::Parameters;

my $starthour = 9;
my $endhour = 18;
# experimented with much shorter day: $starthour = 14;
# experimented with much shorter day: $endhour = 17;

my $daylen = $endhour - $starthour;

my $debug=0;
die "Usage: business-date [--debug] DATETIME DURATION\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;

my $dt = shift;
my $duration = shift;

my $date = Date::Manip::Date->new;
my $err = $date->parse( $dt );
die "business date: date $dt - parse error $err\n" if $err;
die "business date: date $dt - is not a business day/time\n" unless
	is_business_day_and_time( $date );


#
# my $ok = is_business_day_and_time( $date );
#	Given a date object $date, return 1 iff $date is a business day
#	and within business hours, else return 0.
#
fun is_business_day_and_time( $date )
{
	my $dow = $date->printf("%w");
	say "debug ibdt: dow=$dow" if $debug;
	return 0 unless $dow>=1 && $dow<6;

	my( $y, $m, $d, $h, $mn ) = $date->value;
	say "debug ibdt: y=$y, m=$m, d=$d, h=$h, mn=$mn" if $debug;
	return 1 if $h>=$starthour && $h<$endhour;
	return 1 if $h==$endhour && $mn==0;
	return 0;
}


#
# my $rem = remainder_of_business_day( $h, $m );
#	Given a time (hour $h, minute $m) that is within working hours,
#	return the (real) number of hours remaining in that business day.
#
fun remainder_of_business_day( $h, $m )
{
	my $t = $h + $m / 60;
	return $endhour - $t;
}


#
# $date = next_business_day( $date );
#	Move $date to the next business day.
#
fun next_business_day( $date )
{
	my $oneday = Date::Manip::Delta->new;
	my $err = $oneday->parse( "24 hours" );
	die "BUG: oneday '24 hours' - parse error $err\n" if $err;

	my $dow = $date->printf("%w");
	say "debug nbd: dow=$dow" if $debug;

	do
	{
		# move to next physical day
		$date = $date->calc( $oneday );
		$dow++;
		$dow = 1 if $dow>7;
	} while( $dow > 5 );
	return $date;
}


#
# $date = add_business_duration( $date, $duration );
#	Add a +ve duration $duration (real, business hours) to a date $date,
#	returning the resultant date.  This must skip from $endhour:00 to
#	$starthour:00 on the next business day, where necessary.
#
fun add_business_duration( $date, $duration )
{
	my( $y, $m, $d, $h, $mn ) = $date->value;
	say "debug abd: y=$y, m=$m, d=$d, h=$h, mn=$mn" if $debug;

	my $rem = remainder_of_business_day( $h, $mn );
	say "debug abd: remainder of day = $rem hours" if $debug;

	if( $duration <= $rem )
	{
		my $id = int($duration);
		my $md = int(($duration-$id)*60);
		say "debug abd: duration=$duration, id=$id, md=$md" if $debug;

		$h += $id;
		$mn += $md;
		if( $mn > 60 )
		{
			$mn -= 60;
			$h++;
		}
	} else
	{
		# duration goes onto another day; move to end of the day
		$duration -= $rem;

		my $id = int($duration);
		my $md = int(($duration-$id)*60);
		say "debug abd: remaining duration=$duration, id=$id, md=$md"
			if $debug;

		# now advance $date to next business day
		$date = next_business_day( $date );

		# now advance business days while id>=$daylen
		while( $id >= $daylen )
		{
			$date = next_business_day( $date );
			$id -= $daylen;
		}

		( $y, $m, $d ) = $date->value;
		say "debug abd: next business day y=$y, m=$m, d=$d, ".
		    "duration=$duration, id=$id, md=$md" if $debug;

		$h = $starthour + $id;
		$mn = $md;
		say "debug abd: time = $h:". sprintf("%02d",$mn) if $debug;
	}

	my $dstr = "$y-$m-$d $h:". sprintf( "%02d", $mn );
	my $err = $date->parse( $dstr );
	die "add_business: date $dstr - parse error $err\n" if $err;
	return $date;
}


if( $duration > 0 )
{
	$duration += 0.01;	# fuzz factor to make rounding work better:-)
	$date = add_business_duration( $date, $duration );
}
say $date->printf("%Y-%m-%d %H:%M");
