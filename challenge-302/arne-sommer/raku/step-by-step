#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int,
               :v(:$verbose));

NXT: for 1 .. * -> $start
{
  say ": Start value $start" if $verbose;
  
  my $sum = $start;

  for @ints -> $int
  {
    say ": $sum + ({ $int < 0 ?? $int !! "+$int" }) = { $sum + $int }" if $verbose;
    $sum += $int;
    next NXT if $sum < 1;
  }

  say $start;
  last;
}
