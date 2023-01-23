#!/usr/bin/env raku
use v6;
sub MAIN (*@a) {
   put arithmetic-slices(@a ?? @a !! <1 2 3 4>)
      .map({ '(' ~ .join(',') ~ ')' }).join(', ');
}

sub arithmetic-slices (@array) {
   return if @array < 3;
   my $current-rate = @array[1] - @array[0]; # this keeps the growth rate
   my $run-length = 1; # this tracks whether we're emitting
   return [
      gather for 2 ..^ @array -> $i {
         my $delta = @array[$i] - @array[$i - 1];
         if $current-rate == $delta {
            ++$run-length;
            take [ @array[($i - $_) .. $i].Slip ] for 2 .. $run-length;
         }
         else {
            $current-rate = $delta;
            $run-length = 1;
         }
      }
   ];
}
