#! /usr/bin/env raku

unit sub MAIN (*@values where @values.elems > 0 && all(@values) ~~ /^<[1..9]><[0..9]>*$/, :v(:$verbose));

if $verbose
{
  say ": Combinations: { @values.combinations(2).map({ "(" ~ $_[0] ~ "," ~ $_[1] ~ ")" } ) }";
  say ": Mapped to:    { @values.combinations(2).map({ $_[0] ~& $_[1]} ) }";
}

say @values.combinations(2).map({ $_[0] ~& $_[1]} ).sum;