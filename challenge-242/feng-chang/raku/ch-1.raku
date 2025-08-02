#!/bin/env raku

unit sub MAIN();

my @arr1 = +«(prompt 'Array One: ').words;
my @arr2 = +«(prompt 'Array Two: ').words;

put (@arr1 (-) @arr2).keys.sort.Array.gist, ' ', (@arr2 (-) @arr1).keys.sort.Array.gist;
