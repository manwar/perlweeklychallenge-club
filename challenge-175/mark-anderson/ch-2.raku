#!/usr/bin/env raku
use Prime::Factor;
use experimental :cached;

say (3, 5 ... *).grep(&perfect-totient).head(20);

sub totient($n) is cached
{
    $n * [*] map { 1 - 1/$_ }, squish prime-factors($n.Int);
}

sub perfect-totient($n)
{
    $n == [+] totient($n), &totient ... 1; 
} 
