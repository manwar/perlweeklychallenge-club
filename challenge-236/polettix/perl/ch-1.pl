#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';

say exact_change(@ARGV) ? 'true' : 'false';

sub exact_change (@bills) {
   my %bills_of = map { $_ => 0 } (5, 10, 20);
   for my $bill (@bills) {
      if ($bill == 5) {
         $bills_of{5}++;
      }
      elsif ($bill == 10) {
         return 0 unless $bills_of{5}-- > 0;
         $bills_of{10}++;
      }
      else { # $bill == 20
         return 0 unless $bills_of{5}-- > 0;
         if ($bills_of{10} >= 1) {
            $bills_of{10}--;
         }
         elsif ($bills_of{5} >= 2) {
            $bills_of{5} -= 2;
         }
         else {
            return 0;
         }
      }
   }
   return 1;
}
