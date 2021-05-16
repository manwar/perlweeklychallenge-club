#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0); 

my $matches = 0;

climb(0);

sub climb ($sum)
{
  return if $sum > $n;
  if $sum == $n
  {
    $matches++;
    return;
  }

  climb($sum +1);
  climb($sum +2);
}

say $matches;
