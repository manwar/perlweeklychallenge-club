#!/bin/env raku

sub MAIN(UInt:D \Start, UInt:D \Current, Str:D \CSV where *.IO.e) {
    my @music;
    my UInt $cnt;
    CSV.IO.lines».split(',').map({ @music[$cnt++] = (title => .[1], length => .[0]).Hash; });

    my $cycle = @music».<length>.sum / 1000;
    my $pos = (Current - Start) % $cycle;

    $cnt = 0;
    while $pos > @music[$cnt]<length> {
        $pos -= @music[$cnt++]<length>;
    }

    my UInt $hours = ($pos / 3600).UInt;
    $pos -= $hours * 3600;

    my UInt $minutes = ($pos / 60).UInt;
    $pos -= $minutes * 60;

    my UInt $seconds = $pos.UInt;

    put @music[$cnt]<title>;
    put "{ $hours.fmt('%02d') }:{ $minutes.fmt('%02d') }:{ $seconds.fmt('%02d') }";
}
