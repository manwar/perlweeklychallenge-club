#!/bin/env raku

unit sub MAIN(*@strs);

my @lens = @strs».chars;
if [==] @lens {
    put ([eq] @strs) || ([eq] @strs.map(*.substr(0,@lens[0]-1))) ?? +@strs !! -1;
} else {
    my $sz = @lens.min;
    if @strs.map(*.chars - $sz == 0|1).all {
        put ([eq] @strs.map(*.substr(0,$sz))) ?? +@lens.grep(* > $sz) !! -1;
    } else {
        put -1;
    }
}
