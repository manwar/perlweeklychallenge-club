#!/usr/bin/perl
#
# Challenge 1: "Date Finder
# 
# Create a script to accept a 7 digits number, where the first
# number can only be 1 or 2. The second and third digits can be
# anything 0-9. The fourth and fifth digits corresponds to the month
# i.e. 01,02,03....11,12. And the last 2 digits respresents the days in
# the month i.e. 01,02,03....29,30,31. Your script should validate if
# the given number is valid as per the rule and then convert into human
# readable format date.
# 
# RULES
# 
# 1) If 1st digit is 1, then prepend 20 otherwise 19 to the 2nd and 3rd
#    digits to make it 4-digits year.
# 
# 2) The 4th and 5th digits together should be a valid month.
# 
# 3) The 6th and 7th digits together should be a valid day for the above month.
# 
# For example, the given number is 2230120, it should print 1923-01-20.
# "
# 
# My notes: sounds rather straightforward, with or without date manipulation
# modules.  Uses Date::Manip's Date_DaysInMonth(m,y) function.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
use Date::Manip;


die "Usage: ch-1.pl [CODED_DATE]\n" if @ARGV>1;
my $date = shift // "2230120";


#
# my $isodate = validate( $date );
#	Validate the strangely coded date, return undef if it's
#	not valid, or an ISO format date string if it's valid.
#
fun validate( $date )
{
	# must be 7 digits number
	return undef unless $date =~ /^(\d)(\d\d)(\d\d)(\d\d)$/;
	my( $first, $y, $m, $d ) = ( $1, $2, $3, $4 );

	# where the first number can only be 1 or 2.
	return undef unless $first eq '1' || $first eq '2';

	# The second and third digits can be anything 0-9.
	# If 1st digit is 1, then prepend 20 otherwise 19 to the year
	$y = ($first eq '1' ? 20 : 19).$y;

	# The fourth and fifth digits corresponds to the month i.e. 01-12.
	return undef unless $m >= 1 && $m <= 12;

	my $ndays = Date_DaysInMonth( $m, $y );
	say "debug: y=$y, m=$m, ndays=$ndays";

	# The last 2 digits respresents the days in the month i.e. 01-31.
	return undef unless $d >= 1 && $d <= $ndays;

	# Valid: convert into human readable format date.
	return "$y-$m-$d";
}


my $isodate = validate( $date );
if( defined $isodate )
{
	say "$date: valid $isodate";
} else
{
	say "$date: invalid";
}
