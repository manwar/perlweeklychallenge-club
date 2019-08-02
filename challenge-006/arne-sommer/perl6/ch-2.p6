use v6;

sub FatRatRoot (Int $int where $int > 0, :$precision = 10)
{
  my @x =
    FatRat.new(1, 1),
    -> $x { $x - ($x ** 2 - $int) / (2 * $x) } ... *;

  return @x[$precision];
}

say $e ** ($pi * FatRatRoot(163));
