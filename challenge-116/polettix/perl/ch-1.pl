#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub number_sequence ($N) {
   my $length = length $N;
   SIZE:
   for my $l (1 .. $length / 2) {
      my @retval = my $x = substr $N, 0, $l;
      my $start = $l;
      ++$x;
      while ((my $available = $length - $start) > 0) {
         my $xlen = length $x;
         next SIZE if $xlen > $available || substr($N, $start, $xlen) ne $x;
         push @retval, $x;
         $start += $xlen;
         ++$x;
      }
      return @retval;
   }
   return $N;
}

my @inputs = @ARGV ? @ARGV : qw< 1234 91011 10203 >;
say join ',', number_sequence($_) for @inputs;
