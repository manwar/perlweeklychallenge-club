#!/usr/bin/env raku

multi sub MAIN('test') {
    use Test;
    is odd-character('Perl','Preel'), 'e';
    is odd-character('Weekly','Weeakly'), 'a';
    is odd-character('Box','Boxy'), 'y';
    done-testing;
}

multi sub MAIN($s, $t) {
    odd-character($s, $t).say;
}

sub odd-character($s, $t) {
    return ($s.comb.Bag (^) $t.comb.Bag).keys[0]
}
