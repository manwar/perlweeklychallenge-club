#! /usr/bin/env raku

subset PositiveInt0 of Int where * >= 0;

unit sub MAIN (*@N where @N.elems > 0 && all(@N) ~~ PositiveInt0);

my $index = 0;

loop
{
  ( say 1; last ) if $index == @N.end;

  @N[$index].defined && @N[$index]
    ?? ( $index += @N[$index] )
    !! ( say 0; last);
}
