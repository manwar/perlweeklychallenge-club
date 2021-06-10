#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util 'max';

sub maximum_gap (@N) {
   return 0 if @N <= 1;
   (my $p, @N) = sort { $a <=> $b } @N;
   return max(map { (my $d, $p) = ($_ - $p, $_); $d } @N);
}

my @input = @ARGV ? @ARGV : (1, 3, 8, 2, 0);
say maximum_gap(@input);
