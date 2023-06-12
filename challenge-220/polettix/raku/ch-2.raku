#!/usr/bin/env raku
use v6;
sub MAIN (*@ints) {
   .say for squarefuls(@ints);
}

sub squarefuls (@ints) {
   my %seen;
   gather for @ints.permutations -> $candidate {
      next unless is-squareful($candidate);
      take $candidate unless %seen{$candidate.join(',')}++;
   }
}

sub is-squareful ($list) {
   for 1 .. $list.end -> $i {
      my $sum = $list[$i - 1] + $list[$i];
      return False if $sum.sqrt.Int² != $sum;
   }
   return True;
}
