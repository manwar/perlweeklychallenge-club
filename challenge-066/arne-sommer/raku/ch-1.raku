#! /usr/bin/env raku

unit sub MAIN (Int $M, Int $N where $N != 0, :$verbose);

my $count  = 0;
my $negate = $M.sign != $N.sign;
my $M-abs  = $M.abs;
my $N-abs  = $N.abs;

say ": Negate the result: { $negate ?? 'Yes' !! 'No' }" if $verbose;

while $M-abs >= $N-abs
{
  $M-abs -= $N-abs;
  $count++;

  say ": M: $M-abs N: $N-abs = $count" if $verbose;
}

if $negate
{
  $count = -$count;
  $count-- if $M-abs;
}

say $count;
