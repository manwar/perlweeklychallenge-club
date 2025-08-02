#! /usr/bin/env raku

unit sub MAIN ($p where $p.chars > 1,
               $w where $w ~~ /^\w+$/,
               :v(:$verbose));

my $p2      = $p.trans({ '.' => ' ', ',' => ' ' });
my $words   = $p2.words.Bag;
my $count   = $words{$w};
my $without = $words (-) $w xx $count;
my @sorted  = $without.sort({ $^b.value <=> $^a.value });

if $verbose
{
  say ":p: '$p'";
  say ":p: '$p2' (modified)";
  say ":word '$w' found $count times";
  say ":Words: { $words.raku }";
  say ":Without: { $without.raku }";
  say ":Sorted: { @sorted.raku }";
}

say @sorted.first.key;
