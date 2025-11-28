#!/usr/bin/env perl
use strict;
use warnings;

sub meeting_point{
  my ($x,$y) = (0,0);
  foreach my $c(split '',$_[0]){
    if($c eq 'U') {++$y}
    elsif($c eq 'R') {++$x}
    elsif($c eq 'D') {--$y}
    elsif($c eq 'L') {--$x}
  }
  $x == $y == 0
}

printf "%d\n",meeting_point("ULD");
printf "%d\n",meeting_point("ULDR");
printf "%d\n",meeting_point("UUURRRDDD");
printf "%d\n",meeting_point("UURRRDDLLL");
printf "%d\n",meeting_point("RRUULLDDRRUU")

