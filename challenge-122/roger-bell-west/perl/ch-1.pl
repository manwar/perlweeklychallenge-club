#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

is_deeply(aos([10, 20, 30, 40, 50, 60, 70, 80, 90]),[10, 15, 20, 25, 30, 35, 40, 45, 50],'example 1');

sub aos {
  my $m=shift;
  my $n=0;
  my $t=0;
  my @o;
  foreach my $i (@{$m}) {
    $t+=$i;
    $n++;
    push @o,$t/$n;
  }
  return \@o;
}
