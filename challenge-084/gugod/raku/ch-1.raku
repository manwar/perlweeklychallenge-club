#!/usr/bin/env raku

sub reverse-integer (Int $n) {
    my $o = ($n < 0 ?? -1 !! 1) * flip abs $n;
    return (-2³¹ ≤ $o < 2³¹) ?? $o !! 0;
}

for @*ARGS -> $n {
    say $n ~ " -> " ~ reverse-integer($n.Int);
}
