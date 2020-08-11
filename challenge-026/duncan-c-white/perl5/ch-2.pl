#!/usr/bin/perl
#
# Challenge 2: "Create a script that prints mean angles of the given list
# of angles in degrees. Please read 
# https://en.wikipedia.org/wiki/Mean_of_circular_quantities
# that explains the formula in details with an example."
# 
# My notes: So, means of circular quantities as applied to angles, in short
#   meanangle = atan2( average(sin(ai)), average(cos(ai)) )
# (where ai are the input angles a1..aN).  Ok, that seems trivial.
# 

use v5.10;	# for "say"
use strict;
use warnings;
use Math::Trig;

die "Usage: ch-2.pl ANGLE+\n" if @ARGV == 0;

my @angle = @ARGV;

my $xsum=0;
my $ysum=0;

foreach my $angle (@angle)
{
	$xsum += sin( deg2rad( $angle ) );
	$ysum += cos( deg2rad( $angle ) );
}

my $n = @angle;
my $xav = $xsum / $n;
my $yav = $ysum / $n;

my $result = rad2deg( atan2( $xav, $yav ) );

say "circular mean of @angle is $result";

