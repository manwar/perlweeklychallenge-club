#!/usr/bin/env raku

# With help from https://www.geeksforgeeks.org/check-whether-a-given-point-lies-inside-a-triangle-or-not/

use Test;
plan 3;

nok contains-origin((0, 1), ( 1, 0), ( 2,  2));
ok  contains-origin((1, 1), (-1, 1), ( 0, -3));
ok  contains-origin((0, 1), ( 2, 0), (-6,  0));

class point 
{
    has Int $.x;
    has Int $.y;
}

sub area($a, $b, $c)
{
    abs(($a.x * ($b.y - $c.y)) + 
        ($b.x * ($c.y - $a.y)) + 
        ($c.x * ($a.y - $b.y))) / 2; 
}

sub contains-origin($A, $B, $C) 
{
    my $a = point.new(x => $A[0], y => $A[1]);
    my $b = point.new(x => $B[0], y => $B[1]);
    my $c = point.new(x => $C[0], y => $C[1]);
    my $p = point.new(:0x, :0y);

   .UInt given area($a, $b, $c) == area($a, $b, $p) + 
                                   area($b, $c, $p) + 
                                   area($a, $c, $p); 
}
