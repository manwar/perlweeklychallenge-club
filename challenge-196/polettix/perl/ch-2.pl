#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say join ', ',
  map { '[' . join(',', $_->@*) . ']'}
  range_list(@ARGV ? @ARGV : (1, 3, 4, 5, 7));

sub range_list (@array) {
   my @retval;
   for my $v (@array) {
      if (@retval && $retval[-1][1] == $v - 1) {
         $retval[-1][1] = $v;
      }
      else {
         pop @retval if @retval && $retval[-1][0] == $retval[-1][1];
         push @retval, [$v, $v];
      }
   }
   pop @retval if @retval && $retval[-1][0] == $retval[-1][1];
   return @retval;
}
