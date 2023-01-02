#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0, :v(:$verbose));

my @primes = (1 .. $n -1).grep( *.is-prime );

say ":Primes: @primes[]" if $verbose;

say @primes.elems;
