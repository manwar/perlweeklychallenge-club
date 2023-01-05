#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 0 && all(@list) ~~ /^<[0..9]>*$/, :v(:$verbose));

my @sorted = @list.sort;
my @gap;

say ":Sorted: @sorted[]" if $verbose;

my $first = @sorted.shift;

while (@sorted)
{
  my $second = @sorted.shift;
  my $gap    = $second - $first;
  @gap.push: $gap;
  say ":Pair: ($first $second) Gap: $gap" if $verbose;
  $first     = $second;
}

my $max = @gap.max;
my @max = @gap.grep( * == $max );

say ":Max Gap: $max" if $verbose;

say @max.elems;
