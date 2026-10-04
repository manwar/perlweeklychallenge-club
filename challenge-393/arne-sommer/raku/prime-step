#! /usr/bin/env raku

unit sub MAIN (Str $str where $str ~~ /^ <[a..zA..Z]>+ $/, :v(:$verbose));

my @ords  = $str.ords;
my $sum   = @ords.sum;
my $diff  = 0;
my $prime;

loop
{
  if is-prime($sum - $diff)
  {
    $prime = $sum - $diff;
    last;
  }
  if is-prime($sum + $diff)
  {
    $prime = $sum + $diff;
    last;
  }
  $diff++;
}

if $verbose
{
  say ": Ordinals: " ~ @ords.join(", ");
  say ": Sum: $sum";
  say ": Nearest prime: $prime";
}

say $diff;
