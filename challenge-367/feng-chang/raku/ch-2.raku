#!/bin/env raku

unit sub MAIN(*@time);

my method time-to-int(Str:D $t : --> UInt:D) {
    .[0] * 60 + .[1] with $t.comb(/\d\d/)
}

my ($ev1s, $ev1e, $ev2s, $ev2e) = @time».&time-to-int;
if $ev1s > $ev1e {
    $ev1e += 1440;
    $ev2s += 1440;
    $ev2e += 1440;
}
if $ev2s > $ev2e {
    $ev2e += 1440;
    $ev1s += 1440;
    $ev1e += 1440;
}

put($ev1e > $ev2s && $ev2e > $ev1s);
