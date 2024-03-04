#! /usr/bin/env raku

unit sub MAIN (Int $k, *@ints where @ints.elems > 0 && all(@ints) ~~ Int, :v(:$verbose));

my $output = 0;

for ^@ints.elems -> $index
{
  my $binary = $index.fmt('%b');
  my $sum    = $binary.comb.sum;

  if $sum == $k
  {
    $output += @ints[$index];
    say ":Index $index binary $binary -> $sum match - adding @ints[$index] -> $output" if $verbose;
  }
  elsif $verbose
  {
    say ":Index $index binary $binary -> $sum";
  }
}

say $output;
