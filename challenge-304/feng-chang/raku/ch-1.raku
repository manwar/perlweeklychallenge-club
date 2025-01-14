#!/bin/env raku

unit sub MAIN(*@digits);

my $n = @digits.pop;
put $n ≤ @digits.join.match(/(<[0]> ** 3..*)/, :g).map({ len-to-cap(.pos - .from) }).sum;

sub len-to-cap(UInt:D $sz --> UInt:D) {
    ($sz - 1) div 2
}
