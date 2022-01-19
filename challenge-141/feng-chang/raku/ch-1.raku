#!/bin/env raku

my method divisors(UInt:D $n : --> Seq:D) { (1..$n).grep($n %% *) }

put (1..∞).grep(*.&divisors == 8)[^10];
