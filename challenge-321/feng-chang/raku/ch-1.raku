#!/bin/env raku

unit sub MAIN(*@ints where +* %% 2);

@ints = +«@ints.sort;
put +(gather { take (@ints.shift + @ints.pop) / 2 while +@ints }).unique;
