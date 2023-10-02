#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && all(@ints) > 0, :v(:$verbose));

my $bag          = @ints.Bag;
my $combinations = 0;

if $bag.keys >= 3
{
  my @unique = @ints.unique.sort;
  for @unique.combinations(3) -> @combination
  {
    my $add = [*] @combination.map({ $bag{$_} });
    say ": Triplet: ({ @combination.join(",") }) has $add combinations" if $verbose;
    $combinations += $add;
  }
}

say $combinations;
