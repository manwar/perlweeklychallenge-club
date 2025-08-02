#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
               Int :$n where $n > 0 && $n <= @ints.elems,
               :v(:$verbose));

my $max-avg = -Inf;

for 0 .. @ints.elems - $n -> $start
{
  my $avg = @ints[$start .. $start + $n -1].sum / $n;

  if $avg > $max-avg
  {
    $max-avg = $avg;

    say ": New maximum average $max-avg at index $start to { $start + $n -1 }" if $verbose;
  }
  elsif $verbose
  {
     say ": Not a new maximum average $max-avg at index $start to { $start + $n -1 }";
  }
}

say $max-avg;
