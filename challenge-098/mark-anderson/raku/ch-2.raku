#!/usr/bin/env raku
use Test;
plan 4;

is position(3,  (1, 2, 3, 4)),     2;
is position(6,  (1, 3, 5, 7)),     3;
is position(10, (12, 14, 16, 18)), 0;
is position(19, (11, 13, 15, 17)), 4;

sub position($N, @N) 
{ 
    (first * >= $N, :k, @N) // +@N; 
}
