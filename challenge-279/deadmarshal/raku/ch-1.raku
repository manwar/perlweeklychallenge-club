#!/usr/bin/env raku

sub sort-letters(@letters,@weights)
{
  my %h = @letters Z=> @weights;
  %h.sort(*.value)>>.keys.join('')
}

say sort-letters(['R','E','P','L'],[3,2,1,4]);
say sort-letters(['A','U','R','K'],[2,4,1,3]);
say sort-letters(['O','H','Y','N','P','T'],[5,4,2,6,1,3]);

