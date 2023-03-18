#!/bin/env raku

unit sub MAIN(*@N);

@N = @N.sort.unique;
put @N[*-3] // @N.tail;
