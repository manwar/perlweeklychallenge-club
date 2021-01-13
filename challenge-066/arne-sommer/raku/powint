#! /usr/bin/env raku

multi sub MAIN (Int $N where $N.is-prime, :$one)
{
  say 0;
}

multi sub MAIN (Int $N where $N > 1, :$one)
{
  my $match = 0;
  for 2 .. $N.sqrt -> $base
  {
    for 2 .. Inf -> $exp
    {
      my $candidate = $base ** $exp;
      last if $candidate > $N;

      (say "$base^$exp"; $match++; exit if $one) if $candidate == $N;
    }
  }
  say 0 unless $match;
}
