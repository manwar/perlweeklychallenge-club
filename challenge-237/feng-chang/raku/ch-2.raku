#!/bin/env raku

unit sub MAIN(*@nums);

put @nums.permutations.map((@nums Z< *).sum).max;
