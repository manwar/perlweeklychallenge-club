#! /usr/bin/env raku

unit sub MAIN (*@numbers where @numbers.elems > 1 && all(@numbers) ~~ Int,
               :$verbose);

my $grand-total;

for @numbers.combinations(2) -> $list
{
  my $sum = bit-diff(|$list);
  say ": $list -> $sum" if $verbose;
  $grand-total += $sum;
}

say $grand-total;

sub bit-diff (Int $a, Int $b)
{
  return ($a +^ $b).base(2).comb.sum;
}
