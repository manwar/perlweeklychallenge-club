#! /usr/bin/env raku

unit sub MAIN (:v(:$verbose));

say total-zero(5, 4);
say total-zero(4, 6);
say total-zero(2, 5);
say total-zero(3, 1);
say total-zero(7, 4);

sub total-zero ($x is copy, $y is copy)
{
  my $count = 0;

  while $x + $y
  {
     my $x0 = $x;
     my $y0 = $y;

     $x -= $y0 if $x0 >= $y0; 
     $y -= $x0 if $y0 >= $x0;

     $count++;
 
     say ": x:$x0 y:$y0 -> x:$x y:$y [#:$count]" if $verbose;
  }

  return $count;
}
