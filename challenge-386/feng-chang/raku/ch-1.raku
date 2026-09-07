#!/bin/env raku

unit sub MAIN(Str:D $num is copy, UInt:D $base);

my %values = |('0'..'9'), |('A'..'Z'), |('a'..'z'), '+', '-' Z=> 0..63;

my $n = 0;
while $num {
    $n *= $base;
    $n += %values{ $num.substr(0,1) };
    $num .= substr(1);
}
put $n;
