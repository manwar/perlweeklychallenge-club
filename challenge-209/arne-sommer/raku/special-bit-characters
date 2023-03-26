#! /usr/bin/env raku

unit sub MAIN (*@bits where @bits.elems > 0 && all(@bits) eq any(0,1) && @bits[*-1] == 0, :v($verbose));

my $string = "";

while (@bits.elems)
{
  my $first = @bits.shift;

  if $first == 0
  {
    $string ~= 'a';
  }
  elsif (@bits.elems)
  {
    my $second = @bits.shift;
    $string ~= $second == 0 ?? 'b' !! 'c';
  }
  else
  {
    $string ~= "ERROR";
  }
}

say ":String: $string" if $verbose;

say + $string.ends-with('a');
