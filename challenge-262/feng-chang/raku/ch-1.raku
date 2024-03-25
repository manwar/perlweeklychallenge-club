#!/bin/env raku

unit sub MAIN(*@ints);

my \posis = +@ints.grep(*>0);
put max(posis, +@ints - posis);
