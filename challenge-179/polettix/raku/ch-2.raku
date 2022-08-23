#!/usr/bin/env raku
use v6;
sub MAIN (*@argv) {
   my @n = @argv ?? @argv.Slip !! < 2 3 4 5 6 7 8 9 8 7 6 5 4 3 2 >;
   put sparkline-string(@n);
}

sub sparkline-string (@n) {
   state @sparks = (0x2581 .. 0x2588).map({ .chr }) ;
   state $n-sparks = @sparks.elems;
   my ($min, $max) = @n.minmax.bounds;

   my @chars;
   if my $delta = ($max - $min) {
      my $scale = ($n-sparks - 1) / $delta;
      @chars = @n.map({ @sparks[($_ - $min) * $scale] });
   }
   else {
      @chars = @sparks[$n-sparks / 2] xx @n.elems;
   }

   return @chars.join('');
}
