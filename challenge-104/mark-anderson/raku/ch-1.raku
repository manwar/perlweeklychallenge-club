#!/usr/bin/env raku

my @fusc = [0, 1];

for 2..^50 -> $even, $odd 
{
    @fusc.push: @fusc[$even div 2];
    @fusc.push: @fusc[$even div 2] + @fusc[($odd + 1) div 2];
}

say @fusc;
