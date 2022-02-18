#!/usr/bin/env raku
use v6;
sub MAIN {
   put rectangle-area([[-1, 0], [2, 2]], [[0, -1], [4, 4]]);
   put rectangle-area([[-3, -1], [1, 3]], [[-1, -3], [2, 2]]);
}

sub rectangle-area ($r1, $r2) {
   return area($r1) + area($r2) - area(intersection($r1, $r2));
}

sub area ($r) { return $r ?? [*] ($r[1] «-» $r[0]).List !! 0  }

sub intersection ($r1, $r2) {
   my $bottom-left = $r1[0] «max» $r2[0];
   my $top-right = $r1[1] «min» $r2[1];
   my $min-difference = ($top-right «-» $bottom-left).min;
   return $min-difference > 0 ?? [$bottom-left, $top-right] !! Nil;
}
