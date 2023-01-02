#!/usr/bin/env raku
use Test;

is prime-count(1),  0;
is prime-count(2),  0;
is prime-count(3),  1;
is prime-count(7),  3;
is prime-count(8),  4;
is prime-count(10), 4;
is prime-count(15), 6;
is prime-count(23), 8;
is prime-count(25), 9;

sub prime-count($n) 
{ 
    (0,1,2,3,5,7...$n-1).grep(&is-prime).elems 
}
