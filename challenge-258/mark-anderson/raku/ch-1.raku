#!/usr/bin/env raku
use Test;

is (10,1,111,24,1000).grep(*.chars %% 2).elems, 3;
is (111,1,11111)     .grep(*.chars %% 2).elems, 0;
is (2,8,1024,256)    .grep(*.chars %% 2).elems, 1;
