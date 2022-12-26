#!/bin/env raku

unit sub MAIN(*@N);

put @N[(^+@N X ^+@N X ^+@N).grep({ .[0] < .[1] < .[2] }).first({ @N[.[0]] < @N[.[2]] < @N[.[1]] }) // []].gist;
