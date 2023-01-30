#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say join ', ', map { '(' . join(',', $_->@*) . ')' }
   arithmetic_slices(@ARGV ? @ARGV : qw< 1 2 3 4 >);

sub arithmetic_slices (@array) {
   return if @array < 3;
   my @retval;
   my $current_rate = $array[1] - $array[0];
   my $run_length = 1;
   for my $i (2 .. $#array) {
      my $delta = $array[$i] - $array[$i - 1];
      if ($current_rate == $delta) {
         ++$run_length;
         push @retval, [ @array[($i - $_) .. $i] ] for 2 .. $run_length;
      }
      else {
         $current_rate = $delta;
         $run_length = 1;
      }
   }
   return @retval;
}
