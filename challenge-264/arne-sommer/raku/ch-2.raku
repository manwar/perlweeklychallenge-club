#! /usr/bin/env raku

unit sub MAIN ($source, $indices, :v(:$verbose));

my @source  = $source.words>>.Int;
my @indices = $indices.words>>.UInt;

die "Note the same number of elems" unless @source.elems == @indices.elems;
die "Index too large" if @indices.max > @indices.elems;

my @target;

for ^@indices.elems -> $index
{
  say ": Source:@source[$index] Index:@indices[$index]" if $verbose;

  @target.splice(@indices[$index], 0, @source[$index]);
}

say "({ @target.join(",") })";
