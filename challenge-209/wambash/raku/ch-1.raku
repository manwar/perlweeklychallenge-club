#!/usr/bin/env raku

my token A {0};
my token B {10};
my token C {11};

multi special-bit-charakters (+@bits) {
    samewith @bits.join
}

multi special-bit-charakters ($str) {
    $str.contains: /^ [ <A> | <B> | <C> ]* <A> $/
}

multi MAIN (Bool :test($)!) {
    use Test;
    is special-bit-charakters(1,0,0),    True;
    is special-bit-charakters(1,1,1,0), False;
    is special-bit-charakters(1110), False;
    done-testing;
}

multi MAIN (Str $sbits) {
    say +special-bit-charakters $sbits
}

multi MAIN (*@bits) {
    say +special-bit-charakters @bits
}
