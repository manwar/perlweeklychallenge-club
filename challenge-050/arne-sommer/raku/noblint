#! /usr/bin/env raku

subset N50 of Int where 50 >= * >= 1;

unit sub MAIN (*@numbers where @numbers.elems >= 3);

die "Illegal non-int input" unless all(@numbers) ~~ N50;

for @numbers.sort.squish -> $number
{
  if @numbers.grep(* > $number).elems == $number
  {
    say $number;
    exit;
  }
}