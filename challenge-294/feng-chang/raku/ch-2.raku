#!/bin/env raku

unit sub MAIN(*@ints);

my $i = (+@ints-2...0).first({ @ints[$_] < @ints[$_+1] });
my $m = @ints[$i^..*-1].grep(* > @ints[$i]).min;

put (|@ints[^$i], $m, |(@ints[$i..*-1] (-) $m).keys.sort).join(',');
