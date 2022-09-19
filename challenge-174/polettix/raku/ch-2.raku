#!/usr/bin/env raku
use v6;
sub MAIN {
   say permutation2rank([< a b c d >]);
   say permutation2rank([< 111 22 3 >]);
   say rank2permutation([ 0, 1, 2 ], 1);
}

sub permutation2rank (@permutation) {
   my $n = @permutation;
   my @baseline = @permutation.sort({$^a.Str cmp $^b.Str});
   my $factor = [*] 1 .. $n;
   (0 .. $n - 2).map({
      my $target = @permutation[$_];
      my $index = 0;
      ++$index while @baseline[$index] ne $target;
      @baseline.splice($index, 1);
      ($factor /= $n - $_) * $index;
   }).sum;
}

sub rank2permutation (@baseline is copy, $r is copy) {
   my $n = @baseline;
   my $factor = [*] 1 ..^ $n;
   return [
      (0 ..^ $n).map({
         my $index = $r div $factor;
         $r %= $factor;
         $factor div= ($n - 1 - $_) if $factor > 1;
         @baseline.splice($index, 1).Slip;
      })
   ];
}
