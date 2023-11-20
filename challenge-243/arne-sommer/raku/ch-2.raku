#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (*@nums where  @nums.elems > 0 && all(@nums) ~~ PosInt,
               :v(:$verbose));

my $sum = 0;

for ^@nums.elems -> $i
{
  for ^@nums.elems -> $j
  {
    my $floor = @nums[$i] div @nums[$j];
    say ": floor(@nums[$i]/@nums[$j]) = $floor" if $verbose;
    $sum += $floor;
  }
}

say $sum;
