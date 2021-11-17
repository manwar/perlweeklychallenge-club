#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13801.pl
#
#        USAGE: ./13801.pl [ YEAR ]
#
#  DESCRIPTION: Print the total number of non-weekend days in the given year
#
#      OPTIONS: If no valid argument is supplied, runs the test suite instead.
# REQUIREMENTS: Time::Piece, Test::More
#         BUGS: Only accepts 4-digit years.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 08/11/21
#===============================================================================

use strict;
use warnings;
use Time::Piece;
use Test::More;

if ($ARGV[0] && $ARGV[0] =~ /^\d{4}$/) {
	print working_days ($ARGV[0]);
	exit;
}

# No valid argument, so run the tests instead
my @tests = (
	{ y => 2022, ld => 'Sat', ly => '0', days => 260 },
	{ y => 2023, ld => 'Sun', ly => '0', days => 260 },
	{ y => 2029, ld => 'Mon', ly => '0', days => 261 },
	{ y => 2030, ld => 'Tue', ly => '0', days => 261 },
	{ y => 2031, ld => 'Wed', ly => '0', days => 261 },
	{ y => 2037, ld => 'Thu', ly => '0', days => 261 },
	{ y => 2021, ld => 'Fri', ly => '0', days => 261 },
	{ y => 2016, ld => 'Sat', ly => '1', days => 261 },
	{ y => 2000, ld => 'Sun', ly => '1', days => 260 },
	{ y => 2012, ld => 'Mon', ly => '1', days => 261 },
	{ y => 1996, ld => 'Tue', ly => '1', days => 262 },
	{ y => 2008, ld => 'Wed', ly => '1', days => 262 },
	{ y => 2020, ld => 'Thu', ly => '1', days => 262 },
	{ y => 2004, ld => 'Fri', ly => '1', days => 262 },
);

plan tests => 14;

for my $t (@tests) {
	is working_days ($t->{y}), $t->{days},
		($t->{ly} ? 'Leap' : 'Non-leap') .
		" year ending on a $t->{ld} has $t->{days} working days";
}

sub working_days {

	# Each year has 52 weeks plus one or two days. Each week has 5 working
	# days. So we have 52 * 5 = 260 working days in our 52 weeks. All that
	# remains is to determine how many extra working days there are.

	my $wdays   = 260;
	my $year    = shift;
	my $lastday = Time::Piece->strptime ("$year-12-31", '%Y-%m-%d');
	my $dow     = $lastday->wday;
	unless ($dow == 1) { 
		if ($dow < 7) {
			$wdays++;    # Weekday, so add 1
		}
		if ($lastday->is_leap_year && $dow != 2) {
			$wdays++;    # Penultimate day of leap year is weekday, so add 1
		}
	}
	return $wdays;
}
