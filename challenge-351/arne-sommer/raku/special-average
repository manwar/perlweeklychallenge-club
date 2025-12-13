#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
                :v(:$verbose));

my @sorted = @ints.sort;
my $min    = @sorted[0];
my $max    = @sorted[*-1];

if $verbose
{
  say ":Min $min, Max: $max";
  say ":Sorted { @sorted.join(",") }";
}

@sorted.shift while @sorted && @sorted[0]   == $min;
@sorted.pop   while @sorted && @sorted[*-1] == $max;

say ":Sorted w/o min/max: { @sorted.join(",") }" if $verbose;

say @sorted.elems ?? @sorted.sum / @sorted.elems !! 0;
