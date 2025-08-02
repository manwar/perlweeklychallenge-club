# No time this week to find a more clever approach; Packing for https://tprc.us/ !

sub task2 ( @timetable --> Seq ) {
    for @timetable -> ( $service_interval, $offset, $duration ) {
        if 60 !%% $service_interval {
            warn "service_interval '$service_interval' does not evenly divide into 60, so results will only be correct for the first hour.";
        }
        if $service_interval <= $offset {
            warn "service_interval '$service_interval' <= offset '$offset'; Unexpected - why dont they back up the offset by one or more service intervals?";
        }
    }

    my $bus_number; # For debugging
    my @bus_trips;
    for @timetable -> ( $service_interval, $offset, $duration ) {
        $bus_number++;
        my @departs = $offset, *+$service_interval … *≥60;
        for @departs -> $depart {
            my $arrive = $depart + $duration;

            push @bus_trips, { :$bus_number, :$depart, :$arrive };
        }
    }
    
    @bus_trips .= sort(+*.<depart>);

    my @skip_times;
    for @bus_trips.rotor(3 => -2) -> (%a, %b, %c) {

        if  [>]   (%b, %c)».<arrive>
        and [!==] (%b, %c)».<depart> {

            my Range $r = %a.<depart> ^.. %b.<depart>;

            append @skip_times, ($r.list Xmod 60);
        }
    }

    return @skip_times.sort;
}

my @tests =
    ( ( (12, 11, 41), (15, 5, 35) )             , (36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47) ),
    ( ( (12, 3, 41), (15, 9, 35), (30, 5, 25) ) , ( 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ) ),

    # From challenge-274/e-choroba/perl/ch-2.pl
    ( ( (30, 0, 10), (31, 1, 9)             ), [] ), # Arrival at the same time
    ( ( (30, 0, 10), (30, 0, 8), (30, 1, 8) ), [] ), # Alternative trumps only one bus
;
use Test; plan +@tests;
for @tests -> ( @in, $expected ) {
    is task2(@in), $expected;
}
