#!/bin/env raku

unit sub MAIN(*@ints);

put roundrobin(@ints[0,2...*].sort, @ints[1,3...*].sort(-*));
