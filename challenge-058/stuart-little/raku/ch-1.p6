#!/usr/bin/env perl6
use v6;

sub versprcs($v) {
    $v.comb.map({ $_.Int || $_ }).map({ $_ ~~ Str && $_.trans(['.','_']=>['_','.']) || $_ })
}

say (@*ARGS[0].&versprcs cmp @*ARGS[1].&versprcs).Int

# run as <script> <1st version number> <2nd version number>
