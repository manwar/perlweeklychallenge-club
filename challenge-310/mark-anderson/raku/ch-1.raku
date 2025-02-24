#!/usr/bin/env raku
use Test;

is-deeply ([∩] [1,2,3,4], [4,5,6,1], [4,2,1,3]), set(1,4); 
is-deeply ([∩] [1,0,2,3], [2,4,5]),              set(2);
is-deeply ([∩] [1,2,3],   [4,5],     [6]),       set();
