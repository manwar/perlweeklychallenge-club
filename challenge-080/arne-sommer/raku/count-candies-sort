#! /usr/bin/env raku

unit sub MAIN (*@N where @N.elems > 0 && all(@N) ~~ Int, :v(:$verbose));

my @C = 1 xx @N.elems;
@N.push: Inf; @N.unshift: Inf;
@C.push: 0; @C.unshift: 0;

my %M = (0..@N.end).map({ $_ => @N[$_] });

for %M.keys.sort({ %M{$^a} <=>  %M{$^b}}) -> $index
{
  @C[$index] = candy-count($index);
  say ": Index $index with value %M{$index} and candies @C[$index]" if $verbose;
}

if $verbose
{
  say ": Ranking w/border: { @N.join(", ") }";
  say ": Candies w/border: { @C.join(", ") }";

  say ": Ranking: { @N[1..@N.end -1].join(", ") }";
  say ": Candies: { @C[1..@N.end -1].join(", ") }";
}

say @C.sum;

sub candy-count ($index)
{
  return 0 if $index == 0|@N.end;

  return max(@C[$index-1], @C[$index+1]) +1 if @N[$index] > @N[$index-1] || @N[$index] > @N[$index+1];

  return 1;
}
