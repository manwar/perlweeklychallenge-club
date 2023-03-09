#! /usr/bin/env raku

unit sub MAIN (*@citations where @citations.elems && all(@citations) ~~ /^ 0 || <[1..9]> <[0..9]>* $/, :v($verbose));

my @sorted = @citations.sort;

say ": Sorted: { @citations.join(", ") }" if $verbose;

for @citations.elems ... 1 -> $index
{
  say "Pos:$index -> val:{ @citations[$index -1] }" if $verbose;
  if @citations[$index -1] >= $index
  {
    say $index;
    last;
  }
}

