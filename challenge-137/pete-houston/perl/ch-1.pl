#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13701.pl
#
#        USAGE: ./13701.pl  
#
#  DESCRIPTION: List years between 1900 and 2100 which have 53 weeks.
#
# REQUIREMENTS: Time::Piece
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 01/11/21
#===============================================================================

use strict;
use warnings;

use Time::Piece ();

# A year clearly cannot have 53 weeks, So what is this task supposed to mean? 
# A dig into the Time::Piece docs reveals when the week number can be 53
# so we'll take that as the definition. It seems to fit the given results.
# https://metacpan.org/pod/Time::Piece#Week-Number

my $skip = 0;
for my $year (1900 .. 2100) {
	next if $year == $skip;
	if (weeks_in_year ($year) > 52) {
		print "$year ";
		$skip = $year + 1; # Cannot have 2 in succession, so skip it
	}
}

sub weeks_in_year {
	my $y = shift;
	return Time::Piece->strptime ("$y-12-31", '%Y-%m-%d')->week;
}
