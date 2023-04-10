#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my $m1 = [ [4, 3, 2, 1],
           [5, 4, 3, 2],
           [6, 5, 4, 3],
         ];
say 'm1: ', is_toepliz_matrix($m1) ? 'true' : 'false';

my $m2 = [ [1, 2, 3],
           [3, 2, 1],
         ];
say 'm2: ', is_toepliz_matrix($m2) ? 'true' : 'false';


sub is_toepliz_matrix ($m) {
   for my $i (1 .. $m->$#*) {
      my ($r0, $r1) = $m->@[$i - 1, $i];
      my $end = $r1->$#*;
      return 0 if $end != $r0->$#*;
      for my $j (1 .. $end) {
         return 0 if $r0->[$j - 1] != $r1->[$j];
      }
   }
   return 1;
}
