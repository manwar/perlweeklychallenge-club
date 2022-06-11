#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util qw< min max >;

say rectangle_area([[-1, 0], [2, 2]], [[0, -1], [4, 4]]);
say rectangle_area([[-3, -1], [1, 3]], [[-1, -3], [2, 2]]);

sub rectangle_area ($r1, $r2) {
   return area($r1) + area($r2) - area(intersection($r1, $r2));
}

sub area ($r) {
   return 0 unless $r;
   return ($r->[1][0] - $r->[0][0]) * ($r->[1][1] - $r->[0][1]);
}

sub intersection ($r1, $r2) {
   my $bottom_left = [
      max($r1->[0][0], $r2->[0][0]),
      max($r1->[0][1], $r2->[0][1]),
   ];
   my $top_right = [
      min($r1->[1][0], $r2->[1][0]),
      min($r1->[1][1], $r2->[1][1]),
   ];
   my $min_difference = min(
      $top_right->[0] - $bottom_left->[0],
      $top_right->[1] - $bottom_left->[1],
   );
   return $min_difference > 0 ? [$bottom_left, $top_right] : undef;
}
