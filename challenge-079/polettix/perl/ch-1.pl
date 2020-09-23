#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub count_bits ($n, $m = 1000000007) {
   my $mask     = 1;
   my $mask_bit = 0;
   while (($n & ~$mask) > $mask) { # scan for highest set bit
      $mask <<= 1;
      $mask_bit++;
   }
   my $n_bits = 0;
   while ($n) {
      while (($n & $mask) == 0) {    # scan for next high bit
         $mask_bit--;
         $mask >>= 1;
      }
      $n &= ~$mask;    # this makes $n less than half of itself
      $n_bits = ($n_bits + 1 + $n + $mask_bit * ($mask >> 1) % $m) % $m;
   } ## end while ($n)
   return $n_bits;
} ## end sub count_bits

sub count_bits_brute_force ($n, $m = 1000000007) {
   my $n_bits = 0;
   $n_bits = ($n_bits + (sprintf('%b', $_) =~ tr/1/1/)) % $m
      for 1 .. $n;
   return $n_bits;
}

my $n = shift || 42;
$n = hex($n) if $n =~ m{\A 0x}imxs;
say count_bits($n);
say {*STDERR} count_bits_brute_force($n) if @ARGV > 0;
