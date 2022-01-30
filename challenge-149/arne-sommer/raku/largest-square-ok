#! /usr/bin/env raku

subset Base of UInt where 1 < * <= 36;

unit sub MAIN (Base $base, :v(:$verbose));

my @digits = (( 0 .. 9, 'A' .. 'Z' ).flat)[0 .. $base -1];


for @digits.permutations.reverse -> @permutation
{
  my $candidate = @permutation.join;

  my $decimal = $candidate.parse-base($base);
  my $sqrt    = $decimal.sqrt;

  say ": Checking $candidate (decimal: $decimal root: $sqrt)" if $verbose;

  if $sqrt ~~ /^\d+$/
  {
    say $candidate.substr(0,1) eq "0" ?? $candidate.substr(1) !! $candidate;
    last;
  }
}
