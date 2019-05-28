use v6;

my @squares = map {$_ ** 2}, 100..*;
my @candidates = grep { .comb.unique >= 5}, @squares;
say @candidates[0];
