#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(divide(5,2),2,'all positive');
is(divide(-5,2),-3,'partly negative');
is(divide(-5,-2),2,'all negative');

sub divide {
  my ($dividend,$divisor)=@_;
  if ($divisor==0) {
    die "Division by zero\n";
  }
  my $sign=1;
  if ($dividend < 0) {
    $sign=-$sign;
    $dividend=-$dividend;
  }
  if ($divisor < 0) {
    $sign=-$sign;
    $divisor=-$divisor;
  }
  my $q=1;
  my @t=([$divisor,$q]);
  while ($divisor < $dividend) {
    $divisor+=$divisor;
    $q+=$q;
    unshift @t,[$divisor,$q];
  }
  my $quotient=0;
  while (my $dq=shift @t) {
    while ($dividend>$dq->[0]) {
      $dividend-=$dq->[0];
      $quotient+=$dq->[1];
    }
  }
  if ($sign<0) {
    $quotient=-$quotient;
    if ($dividend>0) {
      $quotient--;
    }
  }
  return $quotient;
}
