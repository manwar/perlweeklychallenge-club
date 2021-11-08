#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0, :v($verbose));

my $ones = $N.fmt('%b').comb.sum;

if $verbose
{
  say ": Initial value: $N (binary: { $N.fmt('%b') })";
  say ": - Number of one bits: $ones";
}

for $N + 1 .. Inf -> $candidate
{
  say ": Candidate $candidate (binary: { $candidate.fmt('%b') })" if $verbose;

  if $candidate.fmt('%b').comb.sum == $ones
  {
    say $candidate;
    exit;
  }
}
