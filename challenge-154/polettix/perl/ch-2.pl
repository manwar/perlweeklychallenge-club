#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

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

sub is_prime { # https://en.wikipedia.org/wiki/Primality_test
   return if $_[0] < 2;
   return 1 if $_[0] <= 3;
   return unless ($_[0] % 2) && ($_[0] % 3);
   for (my $i = 6 - 1; $i * $i <= $_[0]; $i += 6) {
      return unless ($_[0] % $i) && ($_[0] % ($i + 2));
   }
   return 1;
}
