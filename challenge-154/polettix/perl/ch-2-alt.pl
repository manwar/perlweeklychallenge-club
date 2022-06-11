#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use FindBin '$Bin';
use lib "$Bin/local/lib/perl5";
use Math::Prime::Util 'is_prime';

my $n = shift || 10;
my $it = grep_it(\&is_prime, uniq(padovan_number_iterator()));
say join ', ', map { $it->() } 1 .. $n;

sub padovan_number_iterator {
   my ($Pa, $Pb, $Pc) = (1) x 3;
   return sub {
      (my $retval, $Pa, $Pb, $Pc) = ($Pa, $Pb, $Pc, $Pa + $Pb);
      return $retval;
   };
}

sub uniq ($it) {
   my $previous = $it->();
   return sub {
      while ('necessary') {
         my $current = $it->();
         next if $current == $previous;
         (my $retval, $previous) = ($previous, $current);
         return $retval;
      }
   }
}

sub grep_it ($condition, $it) {
   return sub {
      while ('necessary') {
         my $x = $it->();
         return $x if $condition->($x);
      }
   }
}
