#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0, :v(:$verbose));

my $good = 0;

for 0 .. $str.chars - 3 -> $i
{
  my $substring =  $str.substr($i, 3);
  my $is-good = $substring.comb.Bag.elems == 3;
  $good++ if $is-good;

  say ": Candidate: '$substring' { $is-good ?? "is good ($good)" !! "" }" if $verbose;

}

say $good;