#!/usr/bin/env raku

sub counter-integers ($str) {
    $str
    andthen .comb: /\d+/
    andthen .unique
}

multi MAIN (Bool :test($)!) {
    use Test;
    is counter-integers('the1weekly2challenge2'), (1,2);
    is counter-integers('go21od1lu5c7k'), (21, 1, 5,7);
    is counter-integers('4p3e2r1l'), (4,3,2,1);
    done-testing;
}

multi MAIN ($str) {
    put counter-integers $str;
}
