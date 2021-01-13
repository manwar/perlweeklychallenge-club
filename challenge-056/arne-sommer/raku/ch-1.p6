#! /usr/bin/env raku

subset PositiveInt0 of Int where * >= 0;
subset PositiveInt  of Int where * >= 1;

unit sub MAIN (PositiveInt0 $k where $k >= 0, *@array where @array.elems > 1 && all(@array) ~~ PositiveInt, :$verbose);

my $last = @array.end;

die "Array @array[] is not sorted." unless [<=] @array;

say ": Diff: $k" if $verbose;

for 0 .. $last -> $j
{
  for $j +1 .. $last -> $i
  {
    say ": I:$i (@array[$i]) -> J:$j (@array[$j])" if $verbose;
    say "$i, $j" if @array[$i] - @array[$j] == $k;
    last if @array[$i] - @array[$j] > $k;
  }
}
