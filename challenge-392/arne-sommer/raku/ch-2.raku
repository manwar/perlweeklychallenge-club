#! /usr/bin/env raku

unit sub MAIN (*@words where all(@words) ~~ /<[a..z]>+/, :v(:$verbose));

my $max  = 0;

for 0 ..^ @words.elems -> $i
{
  for $i + 1 ..^ @words.elems -> $j
  {
    next if @words[$i].comb ∩ @words[$j].comb;

    my $product = @words[$i].chars * @words[$j].chars;

    if $product >= $max
    {
      $max = $product;

      say ": Pair: @words[$i] & @words[$j] -> $product [high]" if $verbose;
    }
    elsif $verbose
    {
      say ": Pair: @words[$i] & @words[$j] -> $product";
    }
  }
}

say $max;
