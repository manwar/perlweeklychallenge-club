#!/usr/bin/env raku

sub power-of-two ($n) {
    2 .. *
    andthen .map: { $_ => round $n ** (1/$_)  }\
    andthen .map: { last if .value == 1;  $_  }\    #take-until
    andthen .first: { .value ** .key == $n }
}

multi MAIN ($n) {
    say +so power-of-two $n
}

multi MAIN (Bool :$test) {
    use Test;
    is power-of-two(8),              3 => 2;
    is power-of-two(125),            3 => 5;
    is power-of-two(101**113),     113 => 101;
    is power-of-two(15),           Nil;
    is power-of-two(101**113 - 1), Nil ;
    done-testing;
}
