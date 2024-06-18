#!/usr/bin/env raku
use Test;

is-deeply bus-route([[12,11,41],[15,5,35]]),          (36,37,38,39,40,41,42,43,44,45,46,47);
is-deeply bus-route([[12,3,41],[15,9,35],[30,5,25]]), (0,1,2,3,25,26,27,40,41,42,43,44,45,46,47,48,49,50,51,55,56,57,58,59);

sub bus-route(@r)
{
    @r .= map(&schedule);

    gather for ^60 [Z] [Z] @r -> ($minute, $routes) 
    {
        given $routes.sort({ abs($minute - .<depart>), .<arrive> }) -> $routes
        {
            my @arrivals = $routes>>.<arrive>;

            if @arrivals.head >= 60
            {
                @arrivals = @arrivals >>mod>> 60
            }

            next if @arrivals.head == @arrivals.min;
            
            take $minute
        }
    }
}

sub schedule([$interval, $depart, $duration])
{
    my $departures := $depart, $depart + $interval...60;

    my $schedule = do for flat map { $_ xx $interval }, $departures 
    {
        .Map given :depart($_), :arrive($_ + $duration) 
    }
    
    $schedule.rotate($interval - $depart - 1)
}
