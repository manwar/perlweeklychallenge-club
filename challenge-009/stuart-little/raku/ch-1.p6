#!/usr/bin/env perl6
use v6;

say (1..*).map(* ** 2).first({ $_.comb.unique.elems >= 5 })

# run as <script>
