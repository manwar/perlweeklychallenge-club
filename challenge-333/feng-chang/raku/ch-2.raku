#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.map({ $_ == 0 ?? (0,0) !! $_ }).flat(:hammer).head(+@ints);
