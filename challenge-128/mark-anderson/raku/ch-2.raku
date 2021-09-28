#!/usr/bin/env raku

use Test;
plan 7;

is minimum-platforms(<11:20 14:30>,
                     <11:50 15:00>), 1;

is minimum-platforms(<10:20 11:00 11:10 12:20 16:20 19:00>,
                     <10:30 13:20 12:40 12:50 20:20 21:20>), 3;

is minimum-platforms(<22:30 23:15 00:30 01:00 01:30>,
                     <23:00 23:55 00:50 01:25 02:00>), 1;

is minimum-platforms(<10:00 11:00 11:00 11:30>,
                     <10:30 11:15 11:20 12:00>), 2;

is minimum-platforms(<10:00 11:00 11:00 11:30>,
                     <11:00 11:15 11:20 12:00>), 3;

is minimum-platforms(<23:00 23:10 00:10 23:00 03:00 15:00 21:00 04:20>,
                     <23:30 01:30 03:00 02:10 04:00 16:00 05:00 05:00>), 2;

is minimum-platforms(<21:30 23:00 00:30 09:00 15:00 21:30 23:00 00:30>,
                     <23:30 23:30 03:00 10:30 23:00 23:00 01:00 03:00>), 3;

sub minimum-platforms($arrivals, $departures)
{
    my @arrivals   = arrival-dts($arrivals);
    my @departures = departure-dts(@arrivals.List, $departures);

    my $platforms;
    my $result;

    while @arrivals
    {
        if @arrivals.head <= @departures.head
        {
            @arrivals.shift;
            $result = max $result, ++$platforms;
        }

        else 
        {
            @departures.shift;
            --$platforms;
        }
    }   

    return $result;

    class dt
    {
        has Int $.day;
        has Str $.time;
    }

    multi infix:<< <= >>(dt $a, dt $b) 
    {
        my $r = $a.day <=> $b.day;

        return True  if $r ~~ Less;
        return False if $r ~~ More;

        return $a.time le $b.time;
    }

    sub arrival-dts($arrivals)
    {
        my $day  = 1;
        my $time = '00:00';

        gather for $arrivals<> -> $t
        {
            $day++ if $t lt $time;
            $time = $t;
            take dt.new(:$day, :time($t)); 
        }
    }

    sub departure-dts($arrivals, $departures)
    {
        gather for $arrivals<> Z $departures<>
        {
            my $day = .head.day;
            $day++ if .tail lt .head.time;
            take dt.new(:$day, :time(.tail)); 
        } 
    }
}    
