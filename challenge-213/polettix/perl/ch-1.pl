#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say '(', join(',', fun_sort(@ARGV ? @ARGV : (1 .. 6))), ')';

sub fun_sort (@input) {
   @input = sort { $a <=> $b } @input;
   my $start = 0;
   my $stop = $#input;
   while ($start <= $stop) {
      if ($input[$start] % 2) { # move odds at the end
         push @input, splice @input, $start, 1;
         --$stop;
      }
      else {
         ++$start;
      }
   }
   return @input;
}
