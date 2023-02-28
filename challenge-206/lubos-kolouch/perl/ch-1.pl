#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub shortest_time_in_minutes {
  my @times = @_;
  my $min_diff = 24*60; # maximum possible difference in minutes
  for (my $i=0; $i<@times-1; $i++) {
    for (my $j=$i+1; $j<@times; $j++) {
      my ($h1, $m1) = split /:/, $times[$i];
      my ($h2, $m2) = split /:/, $times[$j];
      my $diff = abs(($h1-$h2)*60 + ($m1-$m2));
      $diff = 24*60 - $diff if $diff > 12*60; # account for circular time
      $min_diff = $diff if $diff < $min_diff;
    }
  }
  return $min_diff;
}

# Test cases
is(shortest_time_in_minutes("00:00", "23:55", "20:00"), 5, "Example 1");
is(shortest_time_in_minutes("01:01", "00:50", "00:57"), 4, "Example 2");
is(shortest_time_in_minutes("10:10", "09:30", "09:00", "09:55"), 15, "Example 3");

done_testing();

