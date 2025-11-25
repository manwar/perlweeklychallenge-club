#!/bin/env raku

unit sub MAIN(Str:D $source, Str:D $target);

my method time-to-min(Str:D $time : --> UInt:D) {
    .substr(0,2) * 60 + .substr(3) with $time
}

my $diff = $target.&time-to-min - $source.&time-to-min;
$diff += 60 * 24 if $diff < 0;
put $diff.polymod(5, 3, 4).sum;
