#!/usr/bin/env perl6

multi sub A( $m where 0, $n ) { $n + 1 }
multi sub A( $m, $n where 0 ) { A($m - 1, 1) }
multi sub A( $m, $n )         { A($m - 1, A($m, $n - 1)) }

sub MAIN ( Int $m, Int $n ) {
  say A($m, $n)
}
