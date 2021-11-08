#!/usr/bin/env raku

#| Given to Integers m and n find if they are friendly numbers
sub MAIN( UInt \m, UInt \n ) {
    my \v = m gcd n;
    (1,2,* * 2...* > v).first(* == v).Bool.Int.say;
}
