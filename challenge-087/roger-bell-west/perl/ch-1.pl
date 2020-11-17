#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

is_deeply(lcs([100, 4, 50, 3, 2]),[2,3,4],'example 1');
is_deeply(lcs([20, 30, 10, 40, 50]),0,'example 2');
is_deeply(lcs([20, 19, 9, 11, 10]),[9,10,11],'example 3');
is_deeply(lcs([20, 19, 18, 11, 10]),[18,19,20],'example 4');

sub lcs {
  my $ns=shift;
  my @l=sort {$a <=> $b} @{$ns};
  my @w;
  my @r;
  while (my $n = shift @l) {
    if ((scalar @w == 0) || $n==$w[-1]+1) {
      push @w,$n;
    } else {
      if (scalar @w > scalar @r) {
        @r=@w;
      }
      @w=($n);
    }
  }
  if (scalar @w > scalar @r) {
    @r=@w;
  }
  if (scalar @r > 1) {
    return \@r;
  } else {
    return 0;
  }
}
