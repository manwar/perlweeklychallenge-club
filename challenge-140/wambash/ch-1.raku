#!/usr/bin/env raku

sub add-binary (+@a) {
    @a
    andthen .map: { :2( ~$_ ) }\
    andthen .sum
    andthen .base(2)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is add-binary( 11,  1), 100;
    is add-binary(101,  1), 110;
    is add-binary( 11,100), 111;
    done-testing;
}

multi MAIN (*@a) {
    say add-binary @a
}
