#! /usr/bin/env raku

unit sub MAIN (*@values where @values.elems > 0 && all(@values) ~~ /^<[1..9]><[0..9]>*$/, :v(:$verbose));

while @values.elems > 1
{
  say ": @values[]" if $verbose;

  @values = next-row(@values);
}

say @values[0];

sub next-row (@values)
{
  my @new;
  
  for (1 .. @values.elems -1) -> $index
  {
    @new.push: @values[1..$index].sum;  
  }
  return @new;
}