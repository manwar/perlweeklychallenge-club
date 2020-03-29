#!/usr/bin/env raku 

my @matrix = [ 1, 2, 3 ],
             [ 4, 5, 6 ],
             [ 7, 8, 9 ];

say "Matrix";
.say for @matrix;

say "\nMatrix rotated 90";
.say for ([Z] @matrix.reverse)>>.Array;

say "\nMatrix rotated 180";
.say for @matrix>>.reverse.reverse>>.Array;

say "\nMatrix rotated 270";
.say for ([Z] @matrix).reverse>>.Array;
