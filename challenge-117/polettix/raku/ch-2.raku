#!/usr/bin/env raku
use v6;

sub find-possible-paths ($N) {
   my @solution = [''],;
   for 1 .. $N -> $i {
      my @new_iteration = [],;
      for 0 ..^ @solution.elems -> $j {
         my $previous = @solution[$j];
         my $left     = @new_iteration[$j];
         my $right    = @new_iteration[$j + 1] = [];
         $left.push:  (@solution[$j].flat X~ 'L').Slip;
         $right.push: (@solution[$j].flat X~ 'R').Slip;
         $right.push: (@new_iteration[$j].flat X~ 'H').Slip;
      }
      @solution = @new_iteration;
      $i.note;
   }
   return @solution[*-1].flat;
}

sub MAIN ($N = 2) { find-possible-paths($N).join(', ').put; }
