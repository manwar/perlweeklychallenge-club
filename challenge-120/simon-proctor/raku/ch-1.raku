#!/usr/bin/env raku

#| Given a 8 bit number split into pairs, reverse each pair and output the result
sub MAIN (UInt $N where $N <= 255) {
    sprintf( "%08d", $N.base(2) ).comb(/../).map(*.flip).join.parse-base(2).say;
}
