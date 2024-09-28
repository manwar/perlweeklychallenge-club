#!/usr/bin/env raku

sub strong-password ($_) {
    0
    max (6- .chars)
    max (3- .contains(/<:Ll>/) - .contains( /<:Lu>/) - .contains( /\d/))
    max .comb( /(.)$0$0/).elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is strong-password('a'),         5;
    is strong-password('aB2'),       3;
    is strong-password('PaaSW0rd'),  0;
    is strong-password('Paaasw0rd'), 1;
    is strong-password('aaaaa'),     2;
    done-testing;
}

multi MAIN ($str) {
    say strong-password $str
}
