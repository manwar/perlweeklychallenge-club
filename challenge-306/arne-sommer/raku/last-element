#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int,
               :v(:$verbose));

while @ints.elems >= 2
{
  my @x-index = @ints.max(:k);
  my $x       = @ints[@x-index[0]];

  sink @ints.splice(@x-index[0], 1);

  if @x-index.elems > 1
  {
    my @y-index = @ints.max(:k);
    sink @ints.splice(@y-index[0], 1);
    say ": Removed x:$x and y:$x -> ({ @ints.join(",") })" if $verbose;
  }
  else
  {
    my @y-index = @ints.max(:k);
    my $y       = @ints[@y-index[0]];
    my $replace = $x - $y;

    sink @ints.splice(@y-index[0], 1, $replace);

    say ": Removed x:$x, replaced y:$y with $replace -> ({ @ints.join(",") })" if $verbose;
  }
}

say @ints.elems ?? @ints.head !! 0;
