#!/bin/env raku

unit sub MAIN(Str:D $str, *@widths);

my %widths = 'a'..'z' Z=> @widths;

my ($lines, $w) X= 0;
for $str.comb -> $c {
    $w += %widths{$c};
    if $w > 100 {
        ++$lines;
        $w = %widths{$c};
    }
}
++$lines if $w > 0;

put "($lines, $w)";
