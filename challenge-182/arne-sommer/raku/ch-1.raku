#! /usr/bin/env raku

unit sub MAIN (*@n where @n.elems > 0 && all(@n) ~~ Int);

my $max = @n.max;

for ^@n.elems -> $index
{
  if @n[$index] == $max
  {
    say $index;
    last;
  }
}
