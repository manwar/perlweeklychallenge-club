#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use List::Util 'sum';

my @args = map { split m{[\s,]*}mxs } @ARGV;
@args = (1, 1, 0, 0, 0, 1) unless @args;
say number_placement_sequential(@args);
say number_placement_parallel(@args);

sub number_placement_sequential ($count, @numbers) {
   my $av = sum map { int(($_ - 1) / 2) } zero_streaks_counts(@numbers);
   return $count <= ($av // 0) ? 1 : 0;
}

sub number_placement_parallel ($count, @numbers) {
   my $av = sum map { $_ > 1 ? $_ - 2 : 0 } zero_streaks_counts(@numbers);
   return $count <= $av ? 1 : 0;
}

sub zero_streaks_counts (@numbers) {
   my @retval = (0);
   for my $n (@numbers) {
      if ($n) { push @retval, 0 if $retval[-1] }
      else    { $retval[-1]++                  }
   }
   pop @retval while @retval && $retval[-1] == 0;
   return @retval;
}
