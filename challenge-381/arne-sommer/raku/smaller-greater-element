#! /usr/bin/env raku

unit sub MAIN (*@ints where @ints.elems > 0 && all(@ints) ~~ Int,
                :v(:$verbose))
{
  my $min      = @ints.min;
  my $max      = @ints.max;
  my @strictly = @ints.grep( $min < * < $max );

  if $verbose
  {
    say ":Min: $min";
    say ":Max: $max";
    say ":Strictly: @strictly[]";
  }

  say @strictly.elems;
}


