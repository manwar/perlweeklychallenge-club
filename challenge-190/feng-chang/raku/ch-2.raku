#!/bin/env raku

unit sub MAIN(UInt:D \N);

my $len = N.chars - 1;
for ^2**$len -> \n {
    my @A = (N.comb »Z~» n.fmt("\%0{$len}b").comb».trans(<0 1> => ('',' '))).join.comb(/\d+/);
    put @A».&{ chr($_ - 1 + 'A'.ord) }.join if 1 ≤ @A.all ≤ 26;
}
