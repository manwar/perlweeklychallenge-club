#!/usr/bin/env raku

sub shuffle-string ($string, +@indices) {
    @indices Z=> $string.comb
    andthen .sort
    andthen .map: *.value
    andthen .join
}

multi MAIN (Bool :test($)!) {
    use Test;
    is shuffle-string('lacelengh', 3,2,0,5,4,8,6,7,1), 'challenge';
    is shuffle-string('rulepark',4,7,3,1,0,5,2,6), 'perlraku';
    done-testing;
}

multi MAIN ($string, +@indices) {
    say shuffle-string $string, @indices
}
