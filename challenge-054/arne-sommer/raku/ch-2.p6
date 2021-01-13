#! /usr/bin/env raku

unit sub MAIN (Int $start where $start >= 1);

my $sequence := gather
{
  take $start;
  my $prev = $start;

  loop
  {
    last if $prev == 1;
    my $new = $prev %% 2 ?? $prev / 2 !! 3 * $prev + 1;
    $prev = $new;
    take $new;
    # last if $prev == 1;
  }
}

say $sequence.join(", ");
