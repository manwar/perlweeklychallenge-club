#!/bin/env raku

unit sub MAIN(Str:D $s, Str:D $c where { $c.chars == 1 and $s.index($c) });

my @indices = $s.index($c);
while my $i = $s.index($c, @indices.tail + 1) {
    @indices.push($i);
}

put '(', (^$s.chars).map({ (@indices »-» $_)».abs.min }).join(', '), ')';
