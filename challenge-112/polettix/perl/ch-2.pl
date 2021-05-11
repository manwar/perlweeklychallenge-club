#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use Math::BigInt;

my $n = shift // 4;
say climb_stairs($n);

sub climb_stairs ($n) { return fibonacci_nth(Math::BigInt->new($n) + 1) }

sub fibonacci_multiply {
   my ($x, $y) = @_;
   @$x = (
      $x->[0] * $y->[0] + $x->[1] * $y->[2],
      $x->[0] * $y->[1] + $x->[1] * $y->[3],
      $x->[2] * $y->[0] + $x->[3] * $y->[2],
      $x->[2] * $y->[1] + $x->[3] * $y->[3],
   );
} ## end sub _multiply

sub fibonacci_power {
   my ($q, $n, $q0) = (@_[0, 1], $_[2] || [@{$_[0]}]);
   return $q if $n < 2;
   fibonacci_power($q, int($n / 2), $q0);
   fibonacci_multiply($q, $q);
   fibonacci_multiply($q, $q0) if $n % 2;
   return $q;
} ## end sub _power

sub fibonacci_nth ($n) {
   my ($zero, $one) = map { Math::BigInt->new($_) } 0 .. 1;
   return
       $n < 1 ? $zero
     : $n < 3 ? $one
     :          fibonacci_power([$one, $one, $one, $zero], $n - 1)->[0];
} ## end sub nth
