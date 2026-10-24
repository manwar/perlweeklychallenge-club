#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @arrivals = @*ARGS[0].words.map({ $_.split(q{:}) });
    my @departures = @*ARGS[1].words.map({ $_.split(q{:}) });

    my @arrivalTimes = @arrivals
        .map({ $_[0] * 60 + $_[1] })
        .sort({ $^a <=> $^b });
    my @departureTimes = @departures
        .map({ $_[0] * 60 + $_[1] })
        .sort({ $^a <=> $^b });

    my $arrival = 0;
    my $departure = 0;
    my $platforms = 0;
    my $minimum = 0;

    while $arrival < @arrivalTimes.elems {
        if @arrivalTimes[$arrival] < @departureTimes[$departure] {
            $platforms++;
            if $platforms > $minimum {
                $minimum = $platforms;
            }
            $arrival++;
        }
        else {
            $platforms--;
            $departure++;
        }
    }

    say $minimum;
}
