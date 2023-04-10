#!/usr/bin/env raku
use v6;
sub MAIN {
   my $m1 = [ [4, 3, 2, 1],
              [5, 4, 3, 2],
              [6, 5, 4, 3],
            ];
   put 'm1: ', is-toepliz-matrix($m1);

   my $m2 = [ [1, 2, 3],
              [3, 2, 1],
            ];
   put 'm2: ', is-toepliz-matrix($m2);
}

sub is-toepliz-matrix ($m) {
   for 1 .. $m.end -> $i {
      my ($r0, $r1) = $m[$i - 1, $i];
      return False unless all($r0[0 .. *-2] «==» $r1[1 .. *-1]);
   }
   return True;
}
