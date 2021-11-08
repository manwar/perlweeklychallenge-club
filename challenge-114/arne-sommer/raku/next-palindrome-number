#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0, :v($verbose));

for $N + 1 .. Inf -> $candidate
{
  say ": Candidate $candidate" if $verbose;

  if $candidate eq $candidate.flip
  {
    say $candidate;
    exit;
  }
}
