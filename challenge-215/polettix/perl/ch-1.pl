#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say count_odd_one_out(@ARGV ? @ARGV : qw< abc xyz def >);

sub count_odd_one_out (@words) {
   my $sum = 0;
   my $i = 0;
   for my $j (1 .. $#words) {
      if ($words[$i] le $words[$j]) { $i = $j }
      else                          { ++$sum  }
   }
   return $sum;
}
