#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my @inputs = @args».split(/<[ \s , ]>+/).Slip.flat;
   @inputs = <1 0 5> unless @inputs;
   put equal-distribution(@inputs);
}

sub equal-distribution (@inputs) {
   my $total = @inputs.sum;
   return -1 unless $total %% @inputs;
   my $average = ($total / @inputs).Int;
   my ($delta, $moves) = 0, 0;
   for @inputs -> $value {
      $moves += $delta.abs;
      $delta += $value - $average;
   }
   return $moves;
}
