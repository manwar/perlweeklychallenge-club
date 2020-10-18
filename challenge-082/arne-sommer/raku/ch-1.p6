#! /usr/bin/env raku

unit sub MAIN (Int $M where $M > 0, Int $N where $N > 0, :i(:$include-self), :v(:$verbose));

my @M-factors = $include-self ?? (1..$M).grep({ $M %% $_ }) !! (1..$M/2).grep({ $M %% $_ });
my @N-factors = $include-self ?? (1..$N).grep({ $N %% $_ }) !! (1..$N/2).grep({ $N %% $_ });

if $verbose
{
  say "Factors of $M: { @M-factors.join(", ") }";
  say "Factors of $N: { @N-factors.join(", ") }";
}

my %common = @M-factors (&) @N-factors;

say "(" ~ %common.keys.sort.join(", ") ~ ")";