#!/bin/env raku

unit sub MAIN(*@ints);

@ints = +«@ints;
my $i = (+@ints-2...0).first({ @ints[$_] < @ints[$_+1] });
my $j = (+@ints-1...$i+1).first({ @ints[$_] > @ints[$i] });
@ints[$i,$j] = @ints[$j,$i];
@ints.splice($i+1, +@ints-$i-1, @ints[$i+1..*-1].reverse);

put @ints.join(',');
