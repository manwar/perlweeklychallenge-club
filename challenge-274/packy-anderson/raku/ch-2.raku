#!/usr/bin/env raku
use v6;

sub routeTimes(@route) {
  my ($interval, $start, $duration) = @route;
  my %times;
  while ($start < 60 + $interval) {
    %times{$start} = $start + $duration;
    $start += $interval;
  }
  return %times;
}

sub faster(@routes) {
  # find the arrival times for each route's departures
  my %times;
  for @routes -> @route {
    for routeTimes(@route).kv -> $start, $arrive {
      if (%times{$start}:exists && %times{$start} > $arrive) {
        # this departure for this route will arrive sooner than
        # the departure for the earlier route, keep this one!
        %times{$start} = $arrive;
      }
      elsif (%times{$start}:!exists) {
        # no route we've seen has a departure at this time
        %times{$start} = $arrive;
      }
    }
  }

  # now look at all the departures and see if there are
  # later departures with earlier arrivals
  my @bad_starts;
  my @starts = %times.keys.sort: *.Int;
  for @starts.kv -> $pos, $start {
    for @starts[$pos+1 .. *] -> $i {
      if (%times{$i} < %times{$start} ) {
        # we found a later departure with an earlier arrival!
        @bad_starts.push($start);
      }
    }
  }
  @bad_starts = @bad_starts.unique;

  # now determine which minutes of the hour we should say
  # "skip the next bus and take the later one"
  my @skip;
  for 0 .. 59 -> $min {
    if (@starts && @bad_starts && @starts[0] == @bad_starts[0]) {
      # we're in a bad window!
      @skip.push($min);
    }
    if (@starts && @starts[0] == $min) {
      @starts.shift; # remove the start time
    }
    if (@bad_starts && @bad_starts[0] == $min) {
      @bad_starts.shift; # remove the bad start time
    }
  }
  return @skip;
}

sub routeJoin(@routes) {
  my @out;
  for @routes -> @route {
    @out.push('[' ~ @route.join(', ') ~ ']')
  }
  return '[ ' ~ @out.join(', ') ~ ' ]'
}

sub solution(@routes) {
  say 'Input: ' ~ routeJoin(@routes);
  say 'Output: [' ~ faster(@routes).join(', ') ~ ']';
}

say "Example 1:";
solution([ [12, 11, 41], [15, 5, 35] ]);

say "\nExample 2:";
solution([ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]);
