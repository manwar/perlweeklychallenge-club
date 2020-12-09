#!/usr/bin/env raku

unit sub MAIN (Int $A where {$A > 0} = 14, Int $B where {$B > 0} = 12);

my ($a, $b, $r) = ($A, $B, 0); # command line args are immutable

say "$a & $b";

if ($a > 1) {
    repeat {
        $r += $b  if $a mod 2;
        say "{ $a div= 2 } & { $b *= 2 } | r: $r";
    } while $a > 1;
}
$r += $b;

say "r: $r";
