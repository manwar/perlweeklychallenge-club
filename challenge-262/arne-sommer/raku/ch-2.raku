#! /usr/bin/env raku

unit sub MAIN (Int $k, *@ints where all(@ints) ~~ Int && @ints.elems > 0, :v(:$verbose));

my $count = 0;

for 0 .. @ints.elems -2 -> $i
{
  for $i +1 .. @ints.elems -1 -> $j
  {
    next unless @ints[$i] == @ints[$j];
    next unless $i * $j %% $k;
    $count++;
    say ": ($i, $j) => ints[$i] == ints[$j] == @ints[$j] and $i x $j = { $i * $j} is divisible by $k" if $verbose;
  }
}

say $count;
