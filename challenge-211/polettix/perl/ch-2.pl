#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

my @args = @ARGV ? @ARGV : 1 .. 8;
say split_same_average(@args) ? 'true' : 'false';

sub split_same_average (@list) {

   # pre-massage the list to only cope with non-negative integers
   (my $min, @list) = sort { $a <=> $b } @list;
   my @partial_sums = (0);
   push @partial_sums, $partial_sums[-1] + ($list[$_] -= $min)
      for 0 .. $#list;
   unshift @list, 0; # put "min" back

   my %cache;
   my $has_subset = sub ($sum, $k, $i = $#list) {
      return 1 if ($sum == 0) && ($k == 0);  # found!
      return 0
         if ($sum < 0)                 # removed more than needed
         || ($i < 0)                   # nothing more to look at
         || ($sum > $partial_sums[$i]) # cannot remove as much as needed
         ;

      # caching on subset size $k and end cursor position $i only, the $sum
      # is a consequence of $k
      return $cache{$k}{$i} //=
            __SUB__->($sum - $list[$i], $k - 1, $i - 1) # try greedy first
         || __SUB__->($sum, $k, $i - 1);                # fallback
   };

   # calculate p and q (average for modified list is p/q)
   my $n = @list;
   my $sum = $partial_sums[-1];
   my $gcd = gcd($sum, $n);
   my ($p, $q) = ($sum / $gcd, $n / $gcd);

   # iterate finding subsets of multiples of q, starting at q itself
   my $k = $q;
   while ($k <= $n / 2) {
      my $S = $p * $k / $q; # target sum
      return 1 if $has_subset->($S, $k);
      $k += $q;
   }

   # nothing found, fail
   return 0;
}

sub gcd ($A, $B) { ($A, $B) = ($B % $A, $A) while $A; return $B }
