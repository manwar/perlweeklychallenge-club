#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   @args = 1 .. 8 unless @args;
   put split-same-average(@args);
}

sub split-same-average (@list) {
   (my $min, @list) = @list.sort.Slip;
   my @partial-sums = 0;
   @partial-sums.push: @partial-sums[*-1] + (@list[$_] -= $min) for ^@list;
   @list.unshift: 0; # put "min" back

   my %cache;
   sub has_subset ($sum, $k, $i = @list.end) {
      return True if ($sum == 0) && ($k == 0);
      return False
         if ($sum < 0)                 # removed more than needed
         || ($i < 0)                   # nothing more to look at
         || ($sum > @partial-sums[$i]) # cannot remove as much as needed
         ;

      # caching on subset size $k and end cursor position $i only, the $sum
      # is a consequence of $k
      return %cache{$k}{$i} //=
            samewith($sum - @list[$i], $k - 1, $i - 1)
         || samewith($sum, $k, $i - 1);
   }

   # calculate p and q (average for modified list is p/q)
   my $n = @list.elems;
   my $sum = @partial-sums[*-1];
   my $gcd = gcd($sum, $n);
   my ($p, $q) = $sum div $gcd, $n div $gcd;

   # iterate finding subsets of multiples of q, starting at q itself
   my $k = $q;
   while $k <= $n div 2 {
      my $S = $p * $k / $q; # target sum
      return True if has_subset($S, $k);
      $k += $q;
   }

   # nothing found, fail
   return False;
}

sub gcd ($A is copy, $B is copy) { ($A, $B) = ($B % $A, $A) while $A; $B }
