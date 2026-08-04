#!/bin/env raku

unit sub MAIN(UInt:D $num is copy, UInt:D $base);

my @digits = |('0'..'9'), |('A'..'Z'), |('a'..'z'), '+', '/';

my $s;
while $num > 0 {
    $s ~= @digits[$num % $base];
    $num div= $base;
}
put $s.flip;
