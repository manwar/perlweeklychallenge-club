#!/bin/env raku

unit sub MAIN(*@ints);

my (\row, \col) = @ints.splice(*-2);
put (+«@ints).rotor(col)».Array.raku;
