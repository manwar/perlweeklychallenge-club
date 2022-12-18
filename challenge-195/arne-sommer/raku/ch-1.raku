#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0, :v(:$verbose));

my $count = 0;

for 1 .. $n -> $candidate
{
  my $special = is-special($candidate);
  $count++ if $special;
  say ": $candidate { "special" if $special }" if $verbose;
}

say $count;

sub is-special ($integer)
{
  return all($integer.comb.Bag.values) == 1;
}
