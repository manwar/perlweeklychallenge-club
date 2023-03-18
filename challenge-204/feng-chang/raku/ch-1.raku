#!/bin/env raku

unit sub MAIN(*@N);

put +([<=] @N or [>=] @N);
