#!/bin/env raku

unit sub MAIN(Str:D $L1, Str:D $L2);

my %pos = $L2.comb(/\d+/).map({ $_ => $++ });

my (@list3, @list4);
for $L1.comb(/\d+/) -> $n {
    %pos{$n}.defined ??
        @list3[%pos{$n}].push($n) !!
        @list4.push($n);
}

put (|@list3[*;*], |@list4.sort).join(',');
