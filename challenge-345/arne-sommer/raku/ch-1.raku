#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
		:s(:$strictly),
		:v(:$verbose));

my $i-offset = 0;

unless $strictly
{
  @ints.unshift: -Inf;
  @ints.push: -Inf;
  $i-offset = -1;
}

my @indices;

for 1 .. @ints.end - 1 -> $i
{
  my $peak = @ints[$i -1] < @ints[$i] > @ints[$i +1];

  say ": index { $i + $i-offset } (@ints[$i -1] < @ints[$i] > @ints[$i +1]) : $peak" if $verbose;

  @indices.push($i + $i-offset) if $peak;
}

say "({ @indices.join(",") })";