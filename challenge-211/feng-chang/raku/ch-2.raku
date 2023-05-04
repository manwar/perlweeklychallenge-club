#!/bin/env raku

unit sub MAIN(*@N);

put +so @N.combinations».sum.any == @N.sum / 2;
