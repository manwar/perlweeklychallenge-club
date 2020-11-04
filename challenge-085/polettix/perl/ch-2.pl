#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub factor ($N) {
   my %retval;
   my @ps = (2, 3);
   my $k = 1;
   while ($N > 1) {
      if (! @ps) {
         push @ps, 6 * $k - 1, 6 * $k + 1;
         $k++;
      }
      my $p = shift @ps;
      while ($N % $p == 0) {
         $retval{$p}++;
         $N /= $p;
      }
   }
   return \%retval;
}

sub power_of_two_integers ($N) {
   my $factors = factor($N);
   my ($min, @others) = sort {$a <=> $b} values $factors->%*;
   return 0 if $min == 1;
   for my $exponent (@others) {
      return 0 if $exponent % $min;
   }
   return 1;
}

my $N = shift // 8;
say power_of_two_integers($N);
