#!/bin/env raku

unit sub MAIN(UInt:D $from, UInt:D $to, UInt:D $count);

put +($from..$to).grep(-> $n {
    my $b = $n.comb.sort.join;
    +(2..9).grep({ ($n*$_).comb.sort.join eq $b }) ≥ $count
});
