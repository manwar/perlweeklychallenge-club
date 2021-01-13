#!/usr/bin/env perl6
use v6;

for $*ARGFILES.slurp.lc.comb.grep({ $_ ~~ /<[a..z]>/}).classify({ $_ }).map({ $_.key => $_.value.elems }).sort(*.key) {.say}

# run as <script> <space-separated list of files>
