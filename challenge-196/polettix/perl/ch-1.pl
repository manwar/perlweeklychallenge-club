#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @result = first_pattern132(@ARGV ? @ARGV : (3, 1, 4, 2));
say "(@result)";

sub first_pattern132 (@list) {
   for my $low (0 .. (@list - 3)) {
      for my $high ($low + 1 .. (@list - 2)) {
         next if $list[$high] <= $list[$low] - 1;
         for my $mid ($high + 1 .. (@list - 1)) {
            return @list[$low, $high, $mid]
               if $list[$low] < $list[$mid] && $list[$mid] < $list[$high];
         }
      }
   }
   return;
}
