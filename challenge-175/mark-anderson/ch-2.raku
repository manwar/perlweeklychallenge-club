#!/usr/bin/env raku
use Prime::Factor;

say (3, 5 ... *).hyper.grep(&perfect-totient).head(20);

sub totient($n)
{
    $n * [*] map { 1 - 1/$_ }, squish prime-factors($n.Int);
}

sub perfect-totient($n)
{
    $n == [+] totient($n), &totient ... 1; 
} 
