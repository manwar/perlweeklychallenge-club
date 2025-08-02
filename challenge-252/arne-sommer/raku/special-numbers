#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int, :v(:$verbose));

my $sum = 0;
my $n   = @ints.elems;

for 1 .. $n -> $i
{
  if $n %% $i
  {
    my $val     = @ints[$i -1];
    my $squared = $val ** 2;

    $sum += $squared;
    say ": Index $i is special -> value:$val -> squared:$squared -> sum:$sum" if $verbose;
  }
}

say $sum;
