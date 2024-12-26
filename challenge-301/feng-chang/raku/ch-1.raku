#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.permutations».join.max;
