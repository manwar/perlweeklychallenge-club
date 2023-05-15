#!/bin/env raku

unit sub MAIN(*@N);

put @N.permutations».join.max;
