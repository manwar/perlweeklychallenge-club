#!/bin/env raku

unit sub MAIN(*@N, Int:D :$size);

my $bag = @N».Int.Bag;
my @groups;

while +$bag {
    my $k = $bag.keys.min;
    my $g = ($k .. ($k + $size - 1)).Bag;

    if $g (<=) $bag {
        $bag (-)= $g;
        @groups.push($g.keys.sort);
    } else {
        put -1;
        exit 1;
    }
}

put @groups.map({ '(' ~ .join(',') ~ ')' }).join(', ');
