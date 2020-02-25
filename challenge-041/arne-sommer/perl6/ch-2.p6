#! /usr/bin/env raku

my $leonardo := (1, 1, { $^a + $^b +1 } ... Inf);

unit sub MAIN ($limit = 20);

say "$_: $leonardo[$_]" for ^$limit;

