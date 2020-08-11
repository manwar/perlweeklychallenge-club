#!/usr/bin/env raku 

unit sub MAIN(UInt $N where 1 < $N <= 50);

my @array = (1..50).pick($N);

my $regex = / [^|\s] (\d+) \s (\d+) \s (\d+) [\s|$] <?{ $0 < $1 > $2 }> /;

my @peaks = gather {
    take @array[0] if @array[0] > @array[1];

    take ~.[1] for @array.join(" ").match($regex, :overlap);

    take @array[*-1] if @array[*-1] > @array[*-2];
}

say "Array: ", @array, "\n";

say "Peaks: ", @peaks;
