#!/usr/bin/env perl
use v5.40;

use List::Util qw( mesh uniq );

sub routeTimes($route) {
  my ($interval, $start, $duration) = @$route;
  my %times;
  while ($start < 60 + $interval) {
    $times{$start} = $start + $duration;
    $start += $interval;
  }
  return %times;
}

sub faster(@routes) {
  # find the arrival times for each route's departures
  my %times;
  foreach my $route ( @routes ) {
    foreach my($start, $arrive) ( routeTimes($route) ) {
      if (exists $times{$start} && $times{$start} > $arrive) {
        # this departure for this route will arrive sooner than
        # the departure for the earlier route, keep this one!
        $times{$start} = $arrive;
      }
      elsif (! exists $times{$start}) {
        # no route we've seen has a departure at this time
        $times{$start} = $arrive;
      }
    }
  }

  # now look at all the departures and see if there are
  # later departures with earlier arrivals
  my @bad_starts;
  my @starts = sort { $a <=> $b } keys %times;
  foreach my($pos, $start) ( mesh [0 .. $#starts], \@starts ) {
    foreach my $i (@starts[$pos+1 .. $#starts]) {
      if ($times{$i} < $times{$start} ) {
        # we found a later departure with an earlier arrival!
        push @bad_starts, $start;
      }
    }
  }
  @bad_starts = uniq @bad_starts;

  # now determine which minutes of the hour we should say
  # "skip the next bus and take the later one"
  my @skip;
  foreach my $min ( 0 .. 59 ) {
    if (@starts && @bad_starts && $starts[0] == $bad_starts[0]) {
      # we're in a bad window!
      push @skip, $min;
    }
    if (@starts && $starts[0] == $min) {
      shift @starts; # remove the start time
    }
    if (@bad_starts && $bad_starts[0] == $min) {
      shift @bad_starts; # remove the bad start time
    }
  }
  return @skip;
}

sub routeJoin(@routes) {
  my @out;
  foreach my $route ( @routes ) {
    push @out, '[' . join(', ', @$route) . ']';
  }
  return '[ ' . join(', ', @out) . ' ]'
}

sub solution(@routes) {
  say 'Input: ' . routeJoin(@routes);
  say 'Output: [' . join(', ', faster(@routes)) . ']';
}

say "Example 1:";
solution([12, 11, 41], [15, 5, 35]);

say "\nExample 2:";
solution([12, 3, 41], [15, 9, 35], [30, 5, 25]);

