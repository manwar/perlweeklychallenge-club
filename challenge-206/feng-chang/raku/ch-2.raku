#!/bin/env raku

unit sub MAIN(*@N where +* %% 2);

put @N.sort[0, 2 ... (+@N-2)].sum;
