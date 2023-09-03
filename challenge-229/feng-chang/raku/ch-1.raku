#!/bin/env raku

unit sub MAIN(*@S);

my $cnt;
for @S -> $s {
    my @a = $s.comb;
    my @b = (1..^+@a).map(-> $j { (@a[$j].ord - @a[$j-1].ord).sign }).unique;
    ++$cnt if +@b !== 1 or @b[0] !== 1|-1;
}
put $cnt;
