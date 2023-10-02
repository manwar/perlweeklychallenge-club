#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int && all(@ints) > 0, :v(:$verbose));

@ints = @ints>>.Int.sort.reverse; 

while @ints.elems > 1
{
  say ":Sorted: @ints[]" if $verbose;
  
  my $y    = @ints.shift;
  my $x    = @ints.shift;
  my $diff = $y - $x;

  say ":List:   @ints[] { $diff ?? "| add $diff (source: $y - $x)" !! "| no add (source $y == $x)" }" if $verbose;

  if $diff
  {
    @ints.push: $diff;
    @ints = @ints.sort.reverse; 
  }
}

say @ints.elems ?? @ints[0] !! 0;
