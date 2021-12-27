#!/bin/env raku

my @candis = (2..47).grep(*.is-prime);
put (@candis X* @candis).grep(* < 100).sort.unique;
