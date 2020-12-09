#!/usr/bin/env raku

unit sub MAIN (
    Int $A is copy where $A > 0 = 14,
    Int $B is copy where $B > 0 = 12
);

my Int $r = 0;
my $format = "%10d & %10d | product: %10d\n";
$format.printf($A,$B, $r);

if ($A > 1) {
    repeat {
        $r += $B  if $A mod 2;
        $format.printf($A div= 2, $B *= 2, $r);
    } while $A > 1;
}
$r += $B;
~(' ' x 24 ~ "| product: %10d\n").printf($r);
