#!/bin/env raku

unit sub MAIN(*@tokens);

put @tokens.map(+?*.match(/^ <[a..z]>+ [ '-' <[a..z]>+ ]? <:P - [-]>? $/)).sum;
