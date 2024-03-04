#!/bin/env raku

unit sub MAIN(*@ints where +* == 5);

my Rat \m = (@ints[2]² - @ints[1] * @ints[3]) / (@ints[0] * @ints[2] - @ints[1]²);
my Rat \q = (@ints[0] * @ints[3] - @ints[1] * @ints[2]) / (@ints[0] * @ints[2] - @ints[1]²);

put m.Int == m && q.Int == q && @ints[4] == m * @ints[2] + q * @ints[3];
