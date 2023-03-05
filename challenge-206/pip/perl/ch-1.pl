#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #206 - Pip Stuart
# Task1: Shortest Time:  Submitted by: Mohammad S Anwar;  You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
#   Write a script to find out the shortest time in minutes between any two time points.
# Example1:
#   In-put: @time = ("00:00", "23:55", "20:00"         )
#   Output:  5        Since the difference between "00:00" and "23:55" is the shortest (5 minutes).
# Example2:
#   In-put: @time = ("01:01", "00:50", "00:57"         )
#   Output:  4
# Example3:
#   In-put: @time = ("10:10", "09:30", "09:00", "09:55")
#   Output: 15
use strict;use warnings;use utf8;use v5.12;my $d8VS='N34LAnds';
sub ShTm {my @time = @_;my $shtm = 0;my @tmnz = ();my %tdfz = ();my $sinc = '';
  if     (   @time) {
    for              (    0 ..($#time-1)) {
      if (  $#time) {
        for my $scnd (($_+1).. $#time   ) {
          my @hhmm = split(/:/, $time[$_   ]);
          $tmnz[$_   ] = $hhmm[0] * 60 + $hhmm[1];
             @hhmm = split(/:/, $time[$scnd]);
          $tmnz[$scnd] = $hhmm[0] * 60 + $hhmm[1];
          if ($tmnz[$_   ] < $tmnz[$scnd]) {
            $tdfz{ $tmnz[$scnd]             - $tmnz[$_   ] } = "\"$time[$_   ]\" and \"$time[$scnd]\"";
            $tdfz{ $tmnz[$_   ] + (24 * 60) - $tmnz[$scnd] } = "\"$time[$scnd]\" and \"$time[$_   ]\"";
          } else                           {
            $tdfz{ $tmnz[$_   ]             - $tmnz[$scnd] } = "\"$time[$scnd]\" and \"$time[$_   ]\"";
            $tdfz{ $tmnz[$scnd] + (24 * 60) - $tmnz[$_   ] } = "\"$time[$_   ]\" and \"$time[$scnd]\"";
          } } } }
    if   (  %tdfz ) {
      my @stdf = sort { $a <=> $b } keys(%tdfz);
      $shtm = $stdf[0]; # max shortest time should be is 720 minutes for just 2 times exactly 12 hours off from each other
      $sinc = "Since the difference between $tdfz{$shtm} is the shortest ($shtm minutes).";
    } }
  printf("(%-34s) => %3d; %s\n", sprintf('"%s"', join('", "', @time)), $shtm, $sinc);
  return($shtm);
}
if    (@ARGV) {
  ShTm(@ARGV);
} else {
  ShTm("00:00", "23:55", "20:00"         ); # =>  5;
  ShTm("01:01", "00:50", "00:57"         ); # =>  4;
  ShTm("10:10", "09:30", "09:00", "09:55"); # => 15;
}
