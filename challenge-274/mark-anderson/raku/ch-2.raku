#!/usr/bin/env raku
use Test;

is-deeply bus-route([[12,11,41],[15,5,35]]),          (36,37,38,39,40,41,42,43,44,45,46,47);
is-deeply bus-route([[12,3,41],[15,9,35],[30,5,25]]), (0,1,2,3,25,26,27,40,41,42,43,44,45,46,47,48,49,50,51,55,56,57,58,59);

sub bus-route(@r)
{
    gather for ^60 -> $minute
    {
        my $arrivals := @r.map({ schedule($_, $minute) })    
                          .sort({ .[0], .[1]  })
                          .map({ .[1] });

        take $minute if $arrivals[0] > any($arrivals[1..*])
    }
}

sub schedule([$interval, $depart, $duration], $minute)
{
    my $departures := $depart, $depart + $interval ... 1000;
    my $next = $departures.first(* >= $minute);
    $next, $next + $duration
}
