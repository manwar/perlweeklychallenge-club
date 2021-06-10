#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub higher_integer_set_bits ($N) {
   sub n_bits ($x) { sprintf('%b', $x) =~ tr/1/1/ };
   my $initial = n_bits($N);
   while ('necessary') {
      ++$N;
      return $N if $initial == n_bits($N);
   }
}

@ARGV = 3 unless @ARGV;
say higher_integer_set_bits($_) for @ARGV;
