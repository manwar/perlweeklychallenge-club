#! /usr/bin/perl6

use Test;

plan 3;

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
  my $quotient=0;
  while ($dividend>$divisor) {
    $dividend-=$divisor;
    $quotient++;
  }
  if ($sign < 0) {
    $quotient=-$quotient;
    if ($dividend>0) {
      $quotient--;
    }
  }
  return $quotient;
}
