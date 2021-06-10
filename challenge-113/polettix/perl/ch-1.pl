#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub represent_integer ($n, $d) {
   return 0 if $n < $d;        # no point in checking this
   return 1 if $n >= 10 * $d;  # n * d + (10 * d + i)  (i < 9)
   return 1 if $n =~ m{$d}mxs; # match one digit
   $n -= $d;
   while ($n > 0) {
      return 1 if represent_integer($n, $d);
      $n -= 10;
   }
   return 0;
}

my $N = shift || 25;
my $D = shift || 7;
say represent_integer($N, $D) ? 1 : 0;
