#! /usr/bin/env raku

unit sub MAIN (*@hours where all(@hours) ~~ UInt && @hours.elems > 1,
               :v(:$verbose));

my $pairs = 0;

for @hours.combinations(2) -> ($first, $second)
{
  next if $first == $second == 0;

  if ($first + $second) %% 24
  {
    $pairs++;

    say ": Pair $pairs: ($first, $second)" if $verbose;
  }
}

say $pairs;
