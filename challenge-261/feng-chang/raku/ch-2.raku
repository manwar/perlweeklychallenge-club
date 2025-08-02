#!/bin/env raku

unit sub MAIN(*@ints);

my $start = @ints.pop;
$start *= 2 while @ints.grep($start);
put $start;
