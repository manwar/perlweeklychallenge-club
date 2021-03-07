#! /usr/bin/env raku

unit sub MAIN (Int $N where $N > 0, :v(:$verbose));

my $lower = (1 ~ 0 x ($N -1)).Int;
my $upper = (9 x $N).Int;

my ($reverse, $add, $subtract, $add-sqrt, $sub-sqrt);
 
say ": Range: $lower - $upper" if $verbose;

for $lower .. $upper -> $number
{
  $reverse  = $number.flip.Int;

  $add      = $number + $reverse;
  next if $add < 0;

  $subtract = $number - $reverse;
  next if $subtract < 0;

  $add-sqrt = $add.sqrt;

  if $add-sqrt.Int == $add-sqrt
  { 
    $sub-sqrt = $subtract.sqrt;
    say $number if $sub-sqrt.Int == $sub-sqrt;
  }
}
