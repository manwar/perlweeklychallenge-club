#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0 && $N <= 255, :v(:$verbose));

my $binary  = $N.fmt('%08b');
my $swapped = $binary.comb(2)>>.flip.join;

if $verbose
{
  say ": Binary:  $binary";
  say ": Swapped: $swapped (binary)";
}

say $swapped.parse-base(2);
