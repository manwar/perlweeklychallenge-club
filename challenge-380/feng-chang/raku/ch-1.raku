#!/bin/env raku

unit sub MAIN(Str:D $word);

my %counts = $word.comb.Bag;
put do with %counts{ %counts.keys.grep(<a e i o u>.any) }.max {
    $_ == -Inf ?? 0 !! $_
} +
    do with %counts{ %counts.keys.grep(<a e i o u>.none) }.max {
    $_ == -Inf ?? 0 !! $_
};
