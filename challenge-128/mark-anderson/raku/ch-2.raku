#!/usr/bin/env raku

use Test;
plan 2;

is minimum-platforms(<11:20 14:30>, <11:50 15:00>), 1, 'Example 1';

is minimum-platforms(<10:20 11:00 11:10 12:20 16:20 19:00>,
                     <10:30 13:20 12:40 12:50 20:20 21:20>), 3, 'Example 2';

sub minimum-platforms($arrivals, $departures)
{
    my @queue;
    my $result;
    my @arrivals   = $arrivals.sort;
    my @departures = $departures.sort;

    while @arrivals
    {
        if @arrivals.head lt @departures.head
        {
            @queue.push: @arrivals.shift;
            $result = max($result, +@queue);
        }

        else 
        {
            @departures.shift;
            @queue.shift;
        }
    }

    $result;
}
