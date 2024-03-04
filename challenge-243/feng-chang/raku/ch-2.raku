#!/bin/env raku

unit sub MAIN(*@nums);

my \N = +@nums;
put (^N X ^N).map({ floor(@nums[.[0]] / @nums[.[1]]) }).sum;
