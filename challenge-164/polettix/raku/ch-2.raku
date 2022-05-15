#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $wanted = 8) {
   my $n = 1;
   my @happy;
   while @happy < $wanted {
      @happy.push: $n if is-happy($n);
      ++$n;
   }
   @happy.join(', ').put;
}

sub is-happy (Int:D $n is copy) {
   state $is-happy = SetHash.new(1);
   return True  if $n ∈ $is-happy;

   state $is-not-happy = SetHash.new;
   return False if $n ∈ $is-not-happy;

   my $round = SetHash.new;
   while $n ∉ $round {
      $round.set($n);
      $n = $n.comb»².sum;
      if $n == 1 {
         $is-happy ∪= $round;
         return 1;
      }
   }
   $is-not-happy ∪= $round;
   return 0;
}
