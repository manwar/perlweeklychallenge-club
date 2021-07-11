#!/usr/bin/perl
# 
# Task 2: "Clock Angle
# 
# You are given time $T in the format hh:mm.
# 
# Write a script to find the smaller angle formed by the hands of an analog
# clock at a given time.
# 
# HINT: A analog clock is divided up into 12 sectors. One sector represents
# 30 degree (360/12 = 30).
# 
# Example
# 
#   Input: $T = '03:10'
#   Output: 35 degree
# 
#   The distance between the 2 and the 3 on the clock is 30 degree.
#   For the 10 minutes i.e. 1/6 of an hour that have passed.
#   The hour hand has also moved 1/6 of the distance between the 3 and the 4,
#   which adds 5 degree (1/6 of 30).
#   The total measure of the angle is 35 degree.
# 
#   Input: $T = '04:00'
#   Output: 120 degree
# "
# 
# My notes: sounds pretty easy.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: clock-angle HH:MM\n" unless
	GetOptions( "debug" => \$debug ) && @ARGV==1;
my $t = shift;

die "clock-angle: bad time $t, should be of format HH:MM\n" unless
	$t =~ /^(\d\d):(\d\d)$/;
my( $h, $m ) = ( $1, $2 );

die "clock-angle: bad hour $h\n" unless $h >= 0 && $h <= 23;
$h %= 12;

die "clock-angle: bad minute $m\n" unless $h >= 0 && $m <= 59;

#say "h=$h, m=$m";

# hour angle correction: adjust for how far through the hour we are
my $hang = 30 * ($h + $m/60);
my $mang = 6 * $m;

#say "h=$h, m=$m, hang=$hang, mang=$mang";

my $angle = abs($hang-$mang);	# angle between hands

say "h=$h, m=$m, hang=$hang, mang=$mang, angle=$angle";
