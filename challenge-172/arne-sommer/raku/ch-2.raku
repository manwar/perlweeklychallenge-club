#! /usr/bin/env raku

unit sub MAIN (*@integers where all(@integers) ~~ Int, :v($verbose));

my @sorted = @integers>>.Int.sort;

say ": Sorted: @sorted[]" if $verbose;

my @fns =
(
  @sorted[0],
  lower_quartile(@sorted),
  median(@sorted),
  upper_quartile(@sorted),
  @sorted[*-1]
);

sub median (@values)
{
  my $count = @values.elems;

  return @values[$count/2] if $count % 2;

  return (@values[$count/2 -0.5] + @values[$count/2 +0.5]) / 2;
}

sub lower_quartile (@values)
{
  my $count = @values.elems;

  return median(@values[0 .. $count/2 -0.5]);
}
 
sub upper_quartile (@values)
{
  my $count = @values.elems;

  return median(@values[$count/2 .. *]);
}
 
say @fns.join(", ");
