#! /usr/bin/env perl6

sub A ( $m, $n ) {
  state %saved;
  %saved{$m}{$n} //= _A( $m, $n )
}

sub _A ( $m, $n ) {
  return $n + 1 unless $m;
  return A( $m - 1, 1 ) unless $n;
  return A( $m - 1, A($m, $n - 1) )
}


sub MAIN ( Int $m, Int $n ) {
  say A($m, $n)
}
