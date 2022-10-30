#!/usr/bin/env raku

subset PosInt of Int where * > 0;

sub MAIN(
  PosInt $x is copy,
  PosInt $y is copy
) {
  my $total-steps = 0;
  my $current-steps;
  ($x, $y) = ($y, $x) if $x < $y;
  repeat {
    ($x, $current-steps) = $x.polymod: $y;
    $total-steps += $current-steps;
    ($x, $y) = ($y, $x);
  } until $y == 0;
  say $total-steps; 
}