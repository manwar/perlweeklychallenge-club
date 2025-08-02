#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 1 && all(@ints) ~~ Int,
               :v(:$verbose));

my @even = @ints.shift;
my @odd  = @ints.shift;

while @ints.elems
{
  @even.push: @ints.shift;
  @odd.push:  @ints.shift if @ints.elems;
}

say ": Even: @even[]\n: Odd: @odd[]" if $verbose;

say "({ (roundrobin(@even.sort, @odd.sort(-*))).flat.join(", ") })";
