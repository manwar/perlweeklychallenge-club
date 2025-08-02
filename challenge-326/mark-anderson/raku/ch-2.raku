#!/usr/bin/env raku
use Test;

is-deeply (1,3,2,4).map({ $^b xx $^a }).flat, (3,4,4);
is-deeply (1,1,2,2).map({ $^b xx $^a }).flat, (1,2,2);
is-deeply (3,1,3,2).map({ $^b xx $^a }).flat, (1,1,1,2,2,2);
