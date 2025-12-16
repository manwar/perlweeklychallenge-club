#!/usr/bin/env perl
use strict;
use warnings;

sub binary_prefix{
  my @res;
  my $x = 0;
  foreach(@{$_[0]}){
    $x = ($x << 1 | $_) % 5;
    push @res,$x == 0 ? 1 : 0;
  }
  @res
}

printf "(%s)\n", join ', ', binary_prefix([0,1,1,0,0,1,0,1,1,1]);
printf "(%s)\n", join ', ', binary_prefix([1,0,1,0,1,0]);
printf "(%s)\n", join ', ', binary_prefix([0,0,1,0,1]);
printf "(%s)\n", join ', ', binary_prefix([1,1,1,1,1]);
printf "(%s)\n", join ', ', binary_prefix([1,0,1,1,0,1,0,0,1,1]);

