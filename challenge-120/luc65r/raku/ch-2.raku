#!/usr/bin/env raku

unit sub MAIN($time where /^ (\d\d) ':' (\d\d) $/);

my $m = $1.Int / 60;
my $h = ($0.Int mod 12 + $m) / 12;
my $d = abs($h - $m);

say "{min($d, 1 - $d) * 360}°";
