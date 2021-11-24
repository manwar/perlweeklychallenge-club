#!/bin/env raku

subset TimeStr of Str where { $^s.match(/^ \d\d ':' \d\d $/) };

my method mytime(TimeStr:D $t: --> DateTime:D) {
    state Date $date = Date.new(now);
    my ($hour, $minute) = $t.split(':');

    DateTime.new(:$date, :$hour, :$minute)
}

sub MAIN(Str:D $f where *.IO.e = 'times.txt') {
    my @lines = $f.IO.lines;
    my @arrivals   = @lines[0].words».&mytime;
    my @departures = @lines[1].words».&mytime;

    (|@arrivals, |@departures).map(-> $t {
        (^@arrivals).grep(-> $i {
            @arrivals[$i] ≤ $t ≤ @departures[$i]
        }).elems
    }).max.put;
}
