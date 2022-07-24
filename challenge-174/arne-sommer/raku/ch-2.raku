#! /usr/bin/env raku

unit sub MAIN (*@i where all(@i) ~~ Int && ! @i.repeated, :$r, :v(:$verbose));

say permutation2rank(@i);
say rank2permutation(@i, $r);

sub permutation2rank(@list)
{
  my @p = @list.sort.permutations;

  for ^@p.elems -> $index
  {
    say ": $index -> @p[$index]" if $verbose;
    return $index if @p[$index] cmp @list == 0;
  }
}

sub rank2permutation(@list, $index)
{
  my @p = @list.sort.permutations;

  return @p[$index];

}