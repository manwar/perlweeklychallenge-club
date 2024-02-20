#!/bin/env raku

unit sub MAIN(*@ints);

put @ints.map(-> \a { +@ints.grep(* < a) }).join(', ');
