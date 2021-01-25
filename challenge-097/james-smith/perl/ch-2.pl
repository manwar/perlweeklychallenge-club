#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( min_flips('101100101',3), 1 );
is( min_flips('10110111', 4), 2 );
is( min_flips('101100100',4), 1 );
is( min_flips('0000000100100011010001010110011110001001101010111100110111101111',4), 32 );

done_testing();

sub min_flips {
  my( $str, $n, @parts ) = @_;;
  my $min = length $str;
  push @parts, substr $str,0,$n,'' while length $str;
  foreach my $r (@parts) {
    my $t = 0;
    foreach my $s (@parts) {
      $t += ($s^$r) =~ tr/\x01/\x01/;
    }
    $min = $t if $t < $min;
  }
  return $min;
}

