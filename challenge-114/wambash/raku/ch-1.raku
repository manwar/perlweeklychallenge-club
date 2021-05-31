#!/usr/bin/env raku

sub next-palindrom-number ($n) {
    my $chars = $n.chars/2;
    $n
    andthen .substr(0,$chars.ceiling)
    andthen $_,$_+1
    andthen .map: { $_ ~ .substr(0,$chars.floor).flip }\
    andthen .first: {$_ > $n}
}

multi MAIN (Bool :test($)!) {
    use Test;
    is next-palindrom-number(1200), 1221;
    is next-palindrom-number(1234), 1331;
    is next-palindrom-number(999),  1001;
    done-testing;
}

multi MAIN ($n) {
    say next-palindrom-number $n
}
