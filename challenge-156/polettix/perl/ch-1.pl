#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use FindBin '$Bin';
use lib "$Bin/local/lib/perl5";
use ntheory 'is_prime';

my $N = shift // 10;
my @pernicious;
my $k = 0;
while (@pernicious < $N) {
   push @pernicious, $k if is_pernicious($k);
   ++$k;
}
say join ', ', @pernicious;

sub is_pernicious ($n) {
   my $count = 0;
   while ($n) {
      ++$count if $n & 1;
      $n >>= 1;
   }
   return is_prime($count);
}
