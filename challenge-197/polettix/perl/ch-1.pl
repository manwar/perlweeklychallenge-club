#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

@ARGV = qw< 1 0 3 0 0 5 > unless @ARGV;
move_zero_in_place(\@ARGV);
{ local $" = ', '; say "(@ARGV)" }

sub move_zero_in_place ($list) {
   my $i = 0;
   my $n_zeros = 0;
   while ($i < $list->@*) {
      if ($list->[$i] == 0) {
         ++$n_zeros;
         splice $list->@*, $i, 1;
      }
      else { ++$i }
   }
   push $list->@*, (0) x $n_zeros;
   return $list;
}
