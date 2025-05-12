#!/bin/env raku

unit sub MAIN(*@ints where +* %% 2);

@ints = +«@ints.sort;
my @avg = gather { take (@ints.shift + @ints.pop) / 2 while +@ints };
put +@avg.unique;
