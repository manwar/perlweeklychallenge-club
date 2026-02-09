#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.map({ $_ ~~ Int ?? .Int !! .chars }).max;
