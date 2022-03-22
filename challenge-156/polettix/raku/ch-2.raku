#!/usr/bin/env raku
use v6;

sub MAIN (*@args) {
   my @inputs = @args ?? |@args !! (12, 70);
   @inputs.map({
      put $_, ' ', is-weird($_);
   });
}

sub proper-divisors (Int:D $n) { (1..($n/2)).grep: $n %% * }

sub is-weird (Int:D $n) {
   my @divs = proper-divisors($n);
   return 0 if @divs.sum <= $n;
   loop {
      my $sum = @divs.sum;
      return 0 if $sum == $n;
      return 1 if $sum < $n;
      my $ms = @divs.pop;
      my $target = $n - $ms;
      for (^(2 ** @divs.elems)).reverse -> $k is copy {
         my $sum = 0;
         my $i = 0;
         while $k > 0 {
            $sum += @divs[$i] if $k +& 1;
            return 0 if $target == $sum;
            ++$i;
            $k +>= 1;
         }
      }
   }
}
