#!/bin/env raku

unit sub MAIN(Str:D $L1, Str:D $L2);

my %pos = $L2.comb(/\d+/).map({ $_ => $++ });
my (@list3, @list4);
for $L1.comb(/\d+/) -> $n {
    with %pos{$n} { @list3[$_].push($n); }
    else          { @list4.push($n); }
}

put (|@list3[*;*], |@list4.sort).join(',');
