#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my ($hr, $min) = get_time();

# 30 degrees per hour
my $hr_angle = $hr * 30;
# Plus the bit for minutes past the hour
$hr_angle += ($min / 60) * 30;

my $min_angle = ($min / 60) * 360;

my $angle = abs( $hr_angle - $min_angle);

$angle = 360 - $angle if $angle > 180;

say $angle;

sub get_time {
  my $err = 'Give me a valid time (HH:MM)';

  die $err unless @ARGV;
  die $err if $ARGV[0] !~ /^\d\d:\d\d$/;

  my ($h, $m) = $ARGV[0] =~ /(\d\d):(\d\d)/;

  die $err if $h > 12 or $m > 59;

  return ($h, $m);
}
