#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util 'sum';

sub sum_of_squares ($N) {
   my $M = sum map { $_ * $_ } split(m{}mxs, $N);
   my $m = int sqrt $M;
   return $m * $m == $M ? 1 : 0;
}

my @inputs = @ARGV ? @ARGV : qw< 34 50 52 >;
say sum_of_squares($_) for @inputs;
