#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.sort.unique.antipairs.Hash{ @ints } »+» 1;
