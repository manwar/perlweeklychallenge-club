#!/bin/env raku

unit sub MAIN(*@nums);

@nums = +«@nums.sort;
put so (@nums Z (|@nums[^2] ... *)[^+@nums]).map({ [==] $_ }).all;
