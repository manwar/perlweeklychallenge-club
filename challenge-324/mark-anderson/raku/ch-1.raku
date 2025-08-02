#!/usr/bin/env raku
use Test;

is (1,2,3,4).batch(2), ((1,2),(3,4));
is (1,2,3)  .batch(3), ((1,2,3));
is (1,2,3,4).batch(1), ((1),(2),(3),(4));
