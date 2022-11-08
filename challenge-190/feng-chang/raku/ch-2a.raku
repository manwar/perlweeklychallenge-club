#!/bin/env raku

unit sub MAIN(UInt:D \N);

my $len = N.chars - 1;
(^2**$len)
    .map(-> \n {
        (N.comb »Z~» n.fmt("\%0{$len}b").comb».trans(<0 1> => ('',' ')))
        .join
        .comb(/\d+/)
    })
    .grep({ 1 ≤ @$_.all ≤ 26 })
    .map(-> $a {
        @$a».&{ chr( $_ - 1 + 'A'.ord ) }.join.put
    });
