#!/usr/bin/env perl6

use v6;

subset Count of Int where * > 0;

#| Script to generate 5-smooth numbers
unit sub MAIN(
  Count :n(:$count) = 20, #= How many 5-smooth numbers to generate.
  *@print #= specific indices to show.
);

# Use a lazy list to generate 5-smooth numbers
my $smooth5 = gather {
  # Initialize some iterators.
  my ($i2, $i3, $i5) := ($smooth5.iterator for ^3);
  my ($n2, $n3, $n5) := 1 xx 3;

  # Just keep generating.  Does the list become sparse?  I don't know!
  loop {
    # Minimum of the latest iterations
    take my $n := ($n2, $n3, $n5).min;

    # Advance the iterators that matched.
    $n2 == $n and $n2 := $i2.pull-one * 2;
    $n3 == $n and $n3 := $i3.pull-one * 3;
    $n5 == $n and $n5 := $i5.pull-one * 5;
  }
}

$smooth5.[^$count].say;

for @print -> $n {
  ($n.fmt('%7d') ~ ': ' ~ @smooth5[$n-1]).say;
}
