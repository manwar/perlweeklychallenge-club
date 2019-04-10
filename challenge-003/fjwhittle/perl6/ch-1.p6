#!/usr/bin/env perl6

use v6;

subset Count of Int where * > 0;

#| Script to generate 5-smooth numbers
unit sub MAIN(
  Count :n(:$count) = 20, #= How many 5-smooth numbers to generate.
  *@print #= specific indices to show.
);

# Use a lazy list to generate 5-smooth numbers
my @smooth5 = lazy gather {
  take 1; # 1 is the first

  # Initialize some iteration counters.
  my ($i2, $i3, $i5) = 0 xx 3;

  # I wanted to use actualy Iterators here, but couldn't figure out how to not
  # pull elements that didn't exist yet.

  # Generate the next number for each divisor
  my $n2 = @smooth5[$i2++] * 2;
  my $n3 = @smooth5[$i3++] * 3;
  my $n5 = @smooth5[$i5++] * 5;

  # Just keep generating.  Does the list become sparse?  I don't know!
  loop {
    # Minimum of the latest iterations
    my $n = ($n2, $n3, $n5).min;
    take $n;

    # Advance the generators that matched.
    $n2 == $n and $n2 = @smooth5[$i2++] * 2;
    $n3 == $n and $n3 = @smooth5[$i3++] * 3;
    $n5 == $n and $n5 = @smooth5[$i5++] * 5;
  }
}

@smooth5.[^$count].say;

for @print -> $n {
  ($n.fmt('%7d') ~ ': ' ~ @smooth5[$n-1]).say;
}
