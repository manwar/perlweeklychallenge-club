#!/bin/env raku

unit sub MAIN(*@ints);

put [+] gather { take @ints.shift ~ (@ints.pop // '') while @ints };
