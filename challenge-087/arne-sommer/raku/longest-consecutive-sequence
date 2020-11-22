#! /usr/bin/env raku

unit sub MAIN (*@N where @N.elems && all(@N) ~~ Int);

my @sorted = @N.sort.squish;

my @longest;
my $longest = 0;
my @current = @sorted.shift;
my $current = @current[0];

for @sorted -> $num
{
  if $num == $current + 1
  {
    @current.push: $num;
    $current = $num;
  }
  else
  {
    if (@current.elems > $longest)
    {
      @longest = @current;
      $longest = @longest.elems;
    }
    $current = $num;
    @current = ($num);
  }
}

say @longest.elems > 1
  ?? "({ @longest.join(", ") })"
  !! "0";
