#! /usr/bin/env raku

unit sub MAIN ($allowed, *@str where @str.elems > 0);

my @allow-canonical = $allowed.comb;

my $consistent = 0;

for @str -> $str
{
  $consistent++ if $str.comb.unique (<=) @allow-canonical;
}

say $consistent;
