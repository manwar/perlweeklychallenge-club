#!/usr/bin/env raku

my @matrix = [ 1, 2, 3 ],
             [ 4, 5, 6 ],
             [ 7, 8, 9 ];

say [Z] @matrix.reverse;               # rotate 90

say @matrix.map({reverse $_}).reverse; # rotate 180

say ([Z] @matrix).reverse;             # rotate 270
