#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util 'min';

sub binary_substrings ($B, $S) {
   die "invalid input string <$B>" unless $B =~ m{\A [01]* \z}mxs;
   my $len = length $B or return 0;
   die "$S is not a factor of the length of <$B>\n" if $len % $S;

   my @parts = map { substr $B, $_ * $S, $S } 0 .. ($len / $S) - 1;
   my @total_distances;
   for my $i (0 .. $#parts - 1) {
      for my $j ($i + 1 .. $#parts) {
         my $d = 0;
         for my $k (0 .. $S - 1) {
            $d++ if substr($parts[$i], $k, 1) ne substr($parts[$j], $k, 1);
         }
         ($total_distances[$_] //= 0) += $d for ($i, $j);
      }
   }
   return min @total_distances;
}

my $binary_string = shift // '101100101';
my $substring_length = shift // 3;
say binary_substrings($binary_string, $substring_length);
