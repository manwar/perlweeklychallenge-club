#!/usr/bin/env perl

use v5.22;
use bigint;
#good luck getting (4, 2) to print, it's 2 ** 65533...

sub ackermann {
  my ($m, $n) = @_;
  state %saved;
  $saved{$m}{$n} //= _ackermann($m, $n)
}

sub _ackermann {
  my ($m, $n) = @_;
  return $n + 1 unless $m;
  return ackermann( $m - 1, 1 ) unless $n;
  return ackermann( $m - 1, ackermann($m, $n - 1) )
}

say ackermann( shift, shift );
