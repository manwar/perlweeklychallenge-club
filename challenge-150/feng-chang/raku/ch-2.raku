#!/bin/env raku

unit sub MAIN(UInt:D \N = 500);

my @nums = 1..N;
@nums .= grep(* !%% $_²) for (2 .. N.sqrt).grep(*.is-prime);

put @nums;
