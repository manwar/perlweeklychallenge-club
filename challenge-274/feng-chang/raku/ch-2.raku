#!/bin/env raku

unit sub MAIN(Str:D $s);

use MONKEY-SEE-NO-EVAL;
my @routes = EVAL $s;

my (@start-schedules, @arrival-schedules);
for @routes -> ($interval, $start, $duration) {
    my @starts = $start, * + $interval ... * ≥ 60;      # list of all start times for the route
    my @arrivals = @starts »+» $duration;               # list of all arrival times for the route

    my @start-table = (^60).map(-> $s { @starts.first($s ≤ *) });     # list of real bus start times for every minute of the hour for the route
    @start-schedules.push(@start-table);

    my @arrival-table = (^60).map(-> $s { @arrivals[@starts.first($s ≤ *, :k)] });    # list of arrival times for every minute of the hour for the route
    @arrival-schedules.push(@arrival-table);
}

put (^60).grep({
    @start-schedules[*;$_].min(:k).none     # none of the id(s) of route(s) first started
        ==                                  #   agree with
    @arrival-schedules[*;$_].min(:k).any    # any of the id(s) of route(s) first arrived
}).join(', ');
