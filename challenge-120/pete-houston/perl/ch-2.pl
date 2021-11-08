#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12002.pl
#
#        USAGE: ./12002.pl HH:MM 
#
#  DESCRIPTION: Print the non-reflex angle in degrees between the clock hands
#
# REQUIREMENTS: IO::All and a UTF-8 compatible terminal
#        NOTES: There is AFAICT no term for an angle less than pi.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 05/07/21
#===============================================================================

use strict;
use warnings;

use IO::All -utf8;

my ($h, $m) = get_input ();

my $minfrac   = $m / 60;
my $hfrac     = ($h + $minfrac) / 12;
my $fracdiff  = abs ($hfrac - $minfrac);

# Ensure we are using the non-reflex angle
$fracdiff = 1 - $fracdiff if $fracdiff > 0.5;

# Convert fraction into angle
my $diffang = $fracdiff * 360;
my $deg     = int $diffang;
my $min     = ($diffang - $deg) * 60;

my $fmt = "At %2.2i:%2.2i, the angle between the hands is " .
	"%i\N{DEGREE SIGN} %.0f'\n"; 
printf $fmt, $h, $m, $deg, $min;

sub get_input {
	my $in = shift @ARGV;
	$in =~ /^([012]?[0-9]):([0-5][0-9])$/ or
		die "'$in' is not a valid time in HH:MM format.\n";
	return ($1 % 12, $2);
}
