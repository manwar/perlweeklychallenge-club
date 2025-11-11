#!/bin/env raku

unit sub MAIN(Str:D $s);

my %months = <Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec> Z=> 1..12;
my ($day, $mon, $yr) = $s.words;
printf '%d-%02d-%02d', $yr, %months{$mon}, $day.substr(0,*-2);
