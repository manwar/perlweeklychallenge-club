#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems >= 1 && all(@ints) ~~ UInt, :v(:$verbose));

my $largest = -1;

for @ints.combinations(1..Inf) -> @combination
{
  say ":Combination: @combination[]" if $verbose;

  for @combination.permutations.unique(:with(&[eqv])) -> @permutation
  {
    my $candidate = @permutation.join;
    my $is-three  = $candidate %% 3;

    if $is-three
    {
      $largest = max($largest, $candidate);
      say ": - Permutation: @permutation[] -> $candidate %% 3" if $verbose;
    }
    else
    {
      say ": - Permutation: @permutation[] -> $candidate" if $verbose;
    }
  }
}

say $largest;