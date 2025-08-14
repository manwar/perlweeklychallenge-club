#! /usr/bin/env raku

unit sub MAIN (*@points where @points.elems > 0 && all(@points) ~~ /^\d+\,\d+$/,
               Int :$x,
	       Int :$y,
               :v(:$verbose));

my $smallest     = Inf;
my $smallest-idx = -1;

for ^@points.elems -> $index
{
  my ($x1, $y1) = @points[$index].split(",")>>.Int;

  next unless $x == $x1 || $y == $y1;

  my $distance = ($x - $x1).abs + ($y - $y1).abs;

  print ": index $index: [$x1, $y1] => $distance" if $verbose;

  if $distance < $smallest
  {
    $smallest     = $distance;
    $smallest-idx = $index;

    say " - New smallest Manhattan Distance" if $verbose;
  }
  elsif $verbose
  {
    say "";
  }
}

say $smallest-idx;
