#!/usr/bin/env raku
use Test;

is-deeply ([\+] 1,2,3,4,5), (1,3,6,10,15);
is-deeply ([\+] 1,1,1,1,1), (1,2,3,4,5);
is-deeply ([\+] 0,-1,1,2),  (0,-1,0,2);
