#!/usr/bin/env raku

sub isbn13 ($n) {
   $n
   andthen .comb(/\d/)
   andthen $_ Z* |(1,3) xx *
   andthen -.sum mod 10
}

multi MAIN (Bool :test($)!) {
    use Test;
    is isbn13('978-0-306-40615-?'),7;
    is isbn13('978-0-123456-47-?'),2;
    done-testing;
}

multi MAIN ($n) {
    say isbn13 $n
}
