#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub largest_multiple (@N) {
   @N = sort { $a <=> $b } @N;
   for my $i (0 .. $#N) {
      if ($N[$i] % 2 == 0) {
         my ($last) = splice @N, $i, 1;
         return join '', reverse(@N), $last;
      }
   }
   return;
}

my @inputs = @ARGV ? @ARGV : qw< 1 0 2 6 >;
say largest_multiple(@inputs);
