#!/usr/bin/env raku

#| Given a number n print all the zero padded binary strings of length n
sub MAIN( UInt $n ) {
     (^(2**$n)).map( { sprintf("\%0{$n}d", $_.base(2) ) } ).join(", ").say;
}
