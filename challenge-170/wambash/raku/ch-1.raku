#!/usr/bin/env raku

constant Primorial = (
  ^∞
  andthen .grep: *.is-prime
  andthen 1, |[\*] $_
);

multi MAIN (Bool :test($)!) {
    use Test;
    is Primorial.head(5), (1,2,6,30,210);
    done-testing;
}

multi MAIN (UInt $n=10) {
    put Primorial.head: $n
}
