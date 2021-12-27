#!/bin/env raku

unit sub MAIN(UInt:D \u, UInt:D \v where v > u);

my @ulam = lazy gather {
    take u;
    take v;

    my $n = 2;
    loop {
        my %b;
        (@ulam[^$n] X @ulam[^$n]).map({ ++%b{.[0]+.[1]} if .[1] > .[0] });
        take %b.keys».UInt.sort.grep({ $_ > @ulam[$n-1] and %b{$_} == 1 }).first;

        ++$n;
    }
};

put @ulam[^10];
