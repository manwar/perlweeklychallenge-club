#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say arithmetic_subsequence(@ARGV);

sub arithmetic_subsequence (@ints) {
   my $n_inputs = @ints;
   return $n_inputs if $n_inputs < 3;
   my $max_len = 2;
   for my $i (0 .. $n_inputs - 3) {
      last if ($n_inputs - $i) <= $max_len; # can't find better
      for my $j ($i + 1 .. $n_inputs - 2) {
         last if (1 + $n_inputs - $j) <= $max_len; # can't find better
         my $step = $ints[$j] - $ints[$i];
         my $next = $ints[$j] + $step;
         my $this_len = 2;
         for my $k ($j + 1 .. $n_inputs - 1) {
            last if ($this_len + $n_inputs - $k) <= $max_len; # ...
            next if $ints[$k] != $next;
            ++$this_len;
            $next += $step;
         }
         $max_len = $this_len if $this_len > $max_len;
      }
   }
   return $max_len;
}
