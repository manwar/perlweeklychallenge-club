#!/usr/bin/env perl6
use v6;

say (1..*).map(* * $_).first({ ($_.comb (-) ('0','1')).elems==0 }) with @*ARGS[0].Int

# run as <script> <numbet>
