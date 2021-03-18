#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub fusc ($n) {
   return [0 .. $n - 1] if $n <= 2;
   my @fusc = (0, 1); # fusc(0), fusc(1)
   while (@fusc < $n) {
      push @fusc, $fusc[@fusc >> 1];
      last if @fusc >= $n;
      push @fusc, $fusc[-1] + $fusc[1 + @fusc >> 1];
   }
   return \@fusc;
}

sub fusc_sieve ($n) {
   my @fusc = (0, 1);
   for my $i (1 .. $n >> 1) {
      $fusc[$i * 2]      = $fusc[$i];
      $fusc[$i * 2 + 1] += $fusc[$i];
      $fusc[$i * 2 - 1] += $fusc[$i];
   }
   $fusc[1] = 1;
   return [@fusc[0 .. $n - 1]];
}

my $N = shift // 50;
my $fusc = fusc_sieve($N);
say "@{[$_ + 1]}. fusc($_) = $fusc->[$_]" for 0 .. $fusc->$#*;
