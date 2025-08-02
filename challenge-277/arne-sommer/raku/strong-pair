#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (*@ints where all(@ints) ~~ PosInt && @ints.elems > 1,
               :v(:$verbose));

my @unique = @ints.unique;
my $count  = 0;

for @unique.combinations(2) -> ($left, $right)
{
  my $is-strong = 0 < abs($left - $right) < min($left, $right);

  say ": Pair ($left, $right) { $is-strong ?? "strong" !! "-" }" if $verbose;

  $count++ if $is-strong;
}

say $count;