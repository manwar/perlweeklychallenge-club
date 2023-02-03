#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #202 - Pip Stuart
# Task2: Widest Valley:  Submitted by: E. Choroba;  Given a profile as a list of altitudes, return the leftmost widest valley.
#   A valley is defined as a subarray of the profile consisting of two parts: the first part is non-increasing and the second part is non-decreasing.
#   Either part can be empty.
# Example1:
#   In-put: 1, 5, 5, 2, 8
#   Output:    5, 5, 2, 8
# Example2:
#   In-put: 2, 6, 8, 5
#   Output: 2, 6, 8
# Example3:
#   In-put: 9, 8, 13, 13, 2, 2, 15, 17
#   Output:       13, 13, 2, 2, 15, 17
# Example4:
#   In-put: 2, 1, 2, 1, 3
#   Output: 2, 1, 2
# Example5:
#   In-put: 1, 3, 3, 2, 1, 2, 3, 3, 2
#   Output:    3, 3, 2, 1, 2, 3, 3
# Last date to submit the solution 23:59 (UK Time) Sunday 5th February 2023.
use strict;use warnings;use utf8;use v5.10.1;my $d8VS='N1ULJEST';
sub WdVl {my @altz=@_;my %valz=();my $wdst=0;my @wdsv=();
  printf "(%-26s) => (", join(', ',@altz);
  for  ( 0..$#altz-1) {my $vwid=0;
    $vwid++ while ($#altz > $_+$vwid && $altz[$_+$vwid] >= $altz[$_+$vwid+1]);
    $vwid++ while ($#altz > $_+$vwid && $altz[$_+$vwid] <= $altz[$_+$vwid+1]);
    if ($vwid >= $wdst) {$wdst=$vwid;push(@{$valz{$wdst}},$_ );}
  } my  $vbgn=shift(@{$valz{$wdst}}); # get leftmost widest valley start index here
  for  ($vbgn..$vbgn+$wdst) {        push(@wdsv,  $altz[  $_]);}
  say join(', ', @wdsv) . ');';
  return(        @wdsv     );
}
if    (@ARGV) {
  WdVl(@ARGV);
} else {
  WdVl(1, 5, 5, 2, 8             ); # => (5, 5, 2, 8);
  WdVl(2, 6, 8, 5                ); # => (2, 6, 8);
  WdVl(9, 8, 13, 13, 2, 2, 15, 17); # => (13, 13, 2, 2, 15, 17);
  WdVl(2, 1, 2, 1, 3             ); # => (2, 1, 2);
  WdVl(1, 3, 3, 2, 1, 2, 3, 3, 2 ); # => (3, 3, 2, 1, 2, 3, 3);
}
