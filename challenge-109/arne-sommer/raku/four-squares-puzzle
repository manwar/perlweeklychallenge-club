#! /usr/bin/env raku

unit sub MAIN (*@values where @values.elems ==7 && all(@values) ~~ Numeric, :s(:$short), :a(:$all) = $short);

for @values.permutations -> @perm
{
  if check-values(@perm)
  {
    if $short
    {
      say "a=@perm[0], b=@perm[1], c=@perm[2], d=@perm[3], e=@perm[4], f=@perm[5], g=@perm[6]";
    }
    else
    {
      my ($a, $b, $c, $d, $e, $f, $g);
      say "a = { $a = @perm[0] }";
      say "b = { $b = @perm[1] }";
      say "c = { $c = @perm[2] }";
      say "d = { $d = @perm[3] }";
      say "e = { $e = @perm[4] }";
      say "f = { $f = @perm[5] }";
      say "g = { $g = @perm[6] }";
      say "";
      say "Box 1: a + b = $a + $b = { $a + $b }";
      say "Box 2: b + c + d = $b + $c  + $d = { $b + $c + $d }";
      say "Box 3: d + e + f = $d + $e  + $f = { $d + $e + $f }";
      say "Box 4: f + g = $f + $g = { $f + $g }";
      say "" if $all;
    }

    last unless $all;
  }
}

sub check-values (@values)
{
  my ($a, $b, $c, $d, $e, $f, $g) = @values;
  return $a + $b == $b + $c + $d == $d + $e + $f == $f + $g;
}
