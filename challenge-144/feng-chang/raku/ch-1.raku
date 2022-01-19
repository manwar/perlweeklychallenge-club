#!/bin/env raku

unit sub MAIN(UInt:D \N = 300);

my @candis = (2..sqrt(N).Int).grep(*.is-prime);
put (@candis X* @candis).grep(* < N).sort.unique;
