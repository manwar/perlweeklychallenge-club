#! /usr/bin/env raku

unit sub MAIN (Int $number, :$verbose);

for 1 .. Inf -> $binary
{
  my $current = $binary.base(2);
  say ": Checking $current" if $verbose;

  if ($current > $number && $current %% $number)
  {
    say "Match: $current";
    exit;
  }
}