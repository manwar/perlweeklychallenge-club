#!/bin/env raku

unit sub MAIN(Str:D $str where /^<alnum>*$/);

my $richness = 3;
--$richness if $str ~~ /<lower>/;
--$richness if $str ~~ /<upper>/;
--$richness if $str ~~ /<digit>/;

my $thickness = $str.match(/(.)$0$0+/, :g).map({ .chars div 3 }).sum;

my $size = 6 - $str.chars;

put max($richness, $thickness, $size);
