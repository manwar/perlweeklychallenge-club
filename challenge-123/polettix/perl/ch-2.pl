#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use constant False => 0;
use constant True  => 1;

use constant tolerance => 1e-7;

package Vector2D {
   use overload
     '-' => sub ($u, $v, $x) { v([ map { $u->[$_] - $v->[$_] } 0, 1 ]) },
     '*' => sub ($u, $v, $x) { $u->dot($v) };

   sub dot ($S, $t)   { return $S->[0] * $t->[0] + $S->[1] * $t->[1] }
   sub length_2 ($S)  { return $S->dot($S) }
   sub v ($v)         { return bless [$v->@*], __PACKAGE__ }
}

sub is_sequence_a_square (@points) {
   my $previous = $points[1] - $points[0];
   for my $i (1 .. $#points - 1) {
      my $current = $points[$i + 1] - $points[$i];
      return False if $previous->length_2 != $current->length_2;
      return False if $previous * $current > tolerance;
      $previous = $current;
   }
   return True;
}

sub is_square (@points) {
   state $permutations = [
      [0, 2, 1, 3],
      [0, 1, 2, 3],
      [0, 2, 3, 1],
   ];
   for my $permutation ($permutations->@*) {
      my @arrangement = map { Vector2D::v($_) } @points[@$permutation];
      return 1 if is_sequence_a_square(@arrangement);
   }
   return 0;
}

say is_square([10, 20], [20, 20], [20, 10], [10, 10]);
say is_square([12, 24], [16, 10], [20, 12], [18, 16]);
say is_square([0, 0], [1, 1], [0, 2], [-1, 1]);
