#! /usr/bin/env raku

unit sub MAIN ($sentence1, $sentence2, :v(:$verbose));

my @words1 = $sentence1.words;
my @words2 = $sentence2.words;

my $once1  = (@words1.Bag.grep: *.value == 1).Bag;
my $once2  = (@words2.Bag.grep: *.value == 1).Bag;

my $common = $once1 (&) $once2;

if $verbose
{
  say ": Once1: { $once1.keys.sort.join(", ") }";
  say ": Once2: { $once2.keys.sort.join(", ") }";
  say ": Common: { $common.keys.sort.join(", ") }";
}

say $common.elems;