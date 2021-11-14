#!raku


class Train {
    has Int $.hour-arrival;
    has Int $.hour-departure;
    has Int $.minute-arrival;
    has Int $.minute-departure;


    submethod BUILD( Str :$arrival, Str :$departure ) {
        $arrival ~~ / (\d+) ':' (\d+) /;
        ( $!hour-arrival, $!minute-arrival ) = $/[ 0 ].Int, $/[ 1 ].Int;
        $departure ~~ / (\d+) ':' (\d+) / ;
        ( $!hour-departure, $!minute-departure ) = $/[ 0 ].Int, $/[ 1 ].Int;
    }

    method collide( Train $other-train ) {
        my $this-arrival   = $!hour-arrival * 60 + $!minute-arrival;
        my $this-departure = $!hour-departure * 60 + $!minute-departure;
        my $other-train-arrival   = $other-train.hour-arrival * 60   + $other-train.minute-arrival;
        my $other-train-departure = $other-train.hour-departure * 60 + $other-train.minute-departure;

        $this-arrival <= $other-train-arrival && $other-train-departure <= $this-departure;
    }
}


sub MAIN() {
    my @arrivals = '10:20', '11:00', '11:10', '12:20', '16:20', '19:00';
    my @departures = '10:30', '13:20', '12:40', '12:50', '20:20', '21:20';


    my @trains.push: Train.new: arrival => @arrivals[ $_ ], departure => @departures[ $_ ] for 0 ..^ @arrivals.elems;

    my $collisions = 0;
    for 0 ..^ @trains.elems -> $current-train {
        $collisions++ if @trains[ $current-train ].collide( @trains[ $_ ] ) for $current-train + 1 ..^ @trains.elems;
    }
    
    "Required platforms: { $collisions + 1 }".say;


}
