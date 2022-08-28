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
# MY NOTES: ok, at least this is more straightforward.  We sort of "wrap
# around" from date D, time 18:00 to date D+1 time 09:00 (when D is
# Mon..Thur), and similarly wrap around from Friday 18:00 to the following
# Monday 09:00..
#
# Investigating what Date and Time module to use, I realise that our old friend
# Date::Manip allows us to cheat: it has a nearly matching concept of business
# dates (Monday..Friday, 08:00..17:00), so we can just use that, altering the
# start and end business hours via:
#	$date->config( "WorkDayBeg", "09:00:00", "WorkDayEnd", "18:00:00" );
# and then doing the calculation via the magic incantation:
#	$delta->parse("in $duration business hours");
#
# ch-2a.pl shows an alternative where we do it ourselves.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Date::Manip::Date;
use Date::Manip::Delta;

my $debug=0;
die "Usage: business-date [--debug] DATETIME DURATION\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==2;

my $dt = shift;
my $duration = shift;

my $date = new Date::Manip::Date;
$date->config( "WorkDayBeg", "09:00:00", "WorkDayEnd", "18:00:00" );
my $err = $date->parse( $dt );
die "business date: date $dt - parse error $err\n" if $err;
die "business date: date $dt - is not a business day/time\n" unless
	$date->is_business_day( 1 );

my $delta = new Date::Manip::Delta;
$err = $delta->parse("in $duration business hours");
die "business date: duration $delta - parse error $err\n" if $err;

my $d = $date->calc( $delta );
say $d->printf("%Y-%m-%d %H:%M");
