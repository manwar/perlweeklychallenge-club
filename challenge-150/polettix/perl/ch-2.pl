#!/usr/bin/env perl
use 5.024;
use warnings;
use English qw< -no_match_vars >;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

if (@ARGV > 1) { 
   say $_, ' ', (is_square_free($_) ? 'is' : 'is not'), ' square free'
      for @ARGV;
}
else {
   my $limit = shift // 500;
   my @list = grep { is_square_free($_) } 1 .. $limit;
   while (@list) {
      print join ', ', splice @list, 0, 20;
      say @list ? ',' : '';
   }
}

sub is_square_free ($N) {
   return unless $N % 4;
   my $divisor = 3;
   while ($N > $divisor) {
      if ($N % $divisor == 0) {
         $N /= $divisor;
         return unless $N % $divisor;
      }
      $divisor += 2; # go through odd candidates only
   }
   return 1;
}
