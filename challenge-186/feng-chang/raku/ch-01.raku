#!/bin/env raku

unit sub MAIN;

my @a = (prompt '@a: ').comb(/\S+/);
my @b = (prompt '@b: ').comb(/\S+/);

put 'zip(@a, @b): ', (@a Z @b).flat;
put 'zip(@b, @a): ', (@b Z @a).flat;
