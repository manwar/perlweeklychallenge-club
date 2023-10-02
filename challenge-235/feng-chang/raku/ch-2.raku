#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.map({ $_ || 0 xx 2 }).flat[^@ints];
