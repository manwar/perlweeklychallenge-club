#!/usr/bin/env perl
use 5.024;
use warnings;
use English qw< -no_match_vars >;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use Math::BigInt;

my $base = shift || 10;
my @ls = largest_square($base);
if ($base <= 36) {
   say join '', turn_to_letters(@ls);
}
else {
   say join ' ', @ls;
}

sub turn_to_letters (@sequence) {
   state $alphabet = ['0' .. '9', 'A' .. 'Z'];
   state $digit_for = {map { $_ => $alphabet->[$_]} 0 .. $alphabet->$#*};
   return map {$digit_for->{$_}} @sequence;
}

sub largest_square ($base = 10) {
   my $max = Math::BigInt->new(0);
   for my $n (reverse 0 .. $base - 1) {
      $max = $max * $base + $n;
   }
   my $candidate = 1 + $max->bsqrt;
   CANDIDATE:
   while ('necessary') {
      --$candidate;
      my $square = $candidate * $candidate;
      my (%flag, @retval);
      while ($square > 0) {
         unshift @retval, my $v = $square % $base;
         next CANDIDATE if $flag{$v}++;
         $square /= $base;
      }
      return @retval;
   }
}
