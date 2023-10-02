#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use Memoize;
no warnings 'recursion';

my @days = @ARGV;
my @costs = splice @days, 0, 3;
memoize('travel_expenditure');
say travel_expenditure(\@costs, @days);

sub travel_expenditure ($costs, @days) {
   state $spans = [1, 7, 30];
   return 0 unless @days;
   my $min;
   for my $i (0 .. 2) {
      my ($first, @pool) = @days;
      shift @pool while @pool && $pool[0] < $first + $spans->[$i];
      my $cost = $costs->[$i] + travel_expenditure($costs, @pool);
      $min = $cost if (! defined($min)) || ($cost < $min);
   }
   return $min;
}
