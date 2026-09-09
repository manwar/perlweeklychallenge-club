#!/bin/env raku

unit sub MAIN(*@ints);

put +@ints.grep({ @ints.any < $_ < @ints.any });
