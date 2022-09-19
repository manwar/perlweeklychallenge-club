#! /usr/bin/env raku

unit sub MAIN (Int $count where $count > 0 = 20);

my $ppc := (1..Inf).map({ next if /0/; $_ ~ "0" ~ $_.flip }).grep: *.is-prime;

say $ppc[^$count].join(", ");
