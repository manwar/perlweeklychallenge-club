#! /usr/bin/env raku

unit sub MAIN (*@array where @array.elems && all(@array) ~~ /^<[0..9]>*$/, :v(:$verbose));

my @valleys;

for ^@array.elems -> $start
{
  my @c = @array[$start..Inf].clone;

  say ":Starting at offset $start; values [ { @c.join(",") } ]" if $verbose;

  my @current = (@c.shift.Int,);

  say ":First: @current[0]" if $verbose;

  my $non-inc = True;

  while (@c.elems)
  {
    my $curr = @c.shift.Int;
    
    if $non-inc && $curr > @current.tail
    {
      $non-inc = False;
    }
    elsif ! $non-inc && $curr < @current.tail
    {
      @valleys.push: @current.clone;
      @current = ();
      last;
    }

    say ":Add: $curr ({ $non-inc ?? "!inc" !! "!desc" })" if $verbose;
    @current.push: $curr;
  }
  @valleys.push: @current if @current.elems;
}

say ":Valleys: { @valleys.raku; }" if $verbose;
say ":Widest: { @valleys>>.elems.max }" if $verbose;

say @valleys.grep({ $_.elems == @valleys>>.elems.max }).first.join(", ");
