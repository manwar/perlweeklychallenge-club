#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say unique_sum(@ARGV);

sub unique_sum (@ints) {
   my $retval = 0;
   my %seen;
   for my $x (@ints) {
      my $previous = $seen{$x}++ // 0;
      $retval += $x unless $previous;
      $retval -= $x if $previous == 1;
   }
   return $retval;
}
