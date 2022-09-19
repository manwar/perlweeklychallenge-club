#!/usr/bin/env raku

sub esthetic-number ($n) {
   $n.comb.cache
   andthen $_ Z[-] .skip
   andthen .all.abs == 1
   andthen .so
}

multi MAIN (Bool :test($)!) {
    use Test;
    is esthetic-number(5456), True;
    is esthetic-number( 120), False;
    done-testing;
}

multi MAIN ($n) {
    say esthetic-number $n
}
