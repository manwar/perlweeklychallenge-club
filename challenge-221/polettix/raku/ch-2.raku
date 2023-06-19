#!/usr/bin/env raku
use v6;
sub MAIN (*@ints) { put arithmetic-subsequence(@ints) }

sub arithmetic-subsequence (@ints) {
   my $n-inputs = @ints.elems;
   return $n-inputs if $n-inputs < 3;
   my $max-len = 2;
   for ^($n-inputs - 2) -> $i {
      last if ($n-inputs - $i) <= $max-len; # can't find better
      for $i ^..^ ($n-inputs - 1) -> $j {
         last if (1 + $n-inputs - $j) <= $max-len; # can't find better
         my $step = @ints[$j] - @ints[$i];
         my $next = @ints[$j] + $step;
         my $this-len = 2;
         for  $j ^..^ $n-inputs -> $k {
            last if ($this-len + $n-inputs - $k) <= $max-len; # ...
            next if @ints[$k] != $next;
            ++$this-len;
            $next += $step;
         }
         $max-len = $this-len if $this-len > $max-len;
      }
   }
   return $max-len;
}
