#!/bin/env raku

unit sub MAIN(*@ints);

put ([\+] 0,|@ints).max;
