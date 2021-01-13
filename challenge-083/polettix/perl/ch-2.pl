#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub flip_array_basic (@A) {
   my $n = scalar(@A); # number of signs that can be flipped
   my $N = 2 ** $n;
   my $i = 0;
   my ($min, $retval);
   while ($i < $N) {
      my $signs = $i++;
      my $sum = 0;
      my $flipped = 0;
      for my $j (0 .. $#A) {
         if ($signs & 0x1) { # flip
            $sum -= $A[$j];
            $flipped++;
         }
         else {
            $sum += $A[$j];
         }
         $signs >>= 1;
      }
      next if $sum < 0;
      ($min, $retval) = ($sum, $flipped)
         if !defined($min)
            || $sum < $min
            || ($sum == $min && $flipped < $retval);
   }
   return $retval;
}

sub flip_array (@A) {
   my $first = shift @A;
   my $n = scalar(@A); # number of signs that can be flipped
   my $N = 2 ** $n;
   my $i = 0;
   my ($min, $retval);
   while ($i < $N) {
      my $signs = $i++;
      my $sum = $first;
      my $flipped = 0;
      for my $j (0 .. $#A) {
         if ($signs & 0x1) { # flip
            $sum -= $A[$j];
            $flipped++;
         }
         else {
            $sum += $A[$j];
         }
         $signs >>= 1;
      }
      my $complementary = $n + 1 - $flipped;
      ($sum, $flipped) = (-$sum, $complementary) if $sum < 0;
      $flipped = $complementary if $sum == 0 && $flipped > $complementary;
      ($min, $retval) = ($sum, $flipped)
         if !defined($min)
            || $sum < $min
            || ($sum == $min && $flipped < $retval);
   }
   return $retval;
}

my @A = @ARGV ? @ARGV : (3, 10, 8);
say flip_array(@A);
