#! /usr/bin/env raku

unit sub MAIN (:v(:$verbose));

say array_degree(1, 3, 3, 2);
say array_degree(1, 2, 1, 3);
say array_degree(1, 3, 2, 1, 2);
say array_degree(1, 1, 2, 3, 2);
say array_degree(2, 1, 2, 1, 1);

sub array_degree (*@array)
{
  my $degree = @array.Bag.map( *.value ).max;
  my @candidates;

  say "\n:Array: ", @array, " with degree $degree" if $verbose;

  for 0 .. @array.elems -1 -> $start
  {
    for $start .. @array.elems -1 -> $stop
    {
      my @slice        = @array[$start .. $stop];
      my $slice_degree = @slice.Bag.map( *.value ).max;

      @candidates.push: @slice if $degree == $slice_degree;

      say ":Slice: [$start - $stop] -> @slice[] { $degree == $slice_degree ?? "+" !! ""} " if $verbose;
    }
  }

  say ":Candidates: ", @candidates if $verbose;

  my @sorted = @candidates.sort({ $^a.elems <=> $^b.elems });

  say ":Sorted: ", @sorted  if $verbose;

  return @sorted.first;
}
