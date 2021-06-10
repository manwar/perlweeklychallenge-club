#!/usr/bin/env raku

sub maximum-gap (+@n) {
    @n
    andthen .sort
    andthen .cache
    andthen .skip Z- $_
    andthen .max max 0
} 

multi MAIN ( *@n ) {
    say maximum-gap @n
}

multi MAIN (Bool :$test!) {
    use Test;
    is maximum-gap(2,9,3,5), 4;
    is maximum-gap(1,3,8,2,0), 5;
    is maximum-gap(5),0;
    done-testing;
}
