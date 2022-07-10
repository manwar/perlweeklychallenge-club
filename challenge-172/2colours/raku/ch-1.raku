#!/usr/bin/env raku

constant @primes = (1 .. *).grep: &is-prime;

multi prime-partition($sum, $count) {
  gather samewith $sum, $count, 1, ()
}

#bound check (could be more accurate for sure)
sub unfinishable($sum, $count, $chosen-prime) { $sum < $count * $chosen-prime }

#terminating when done
multi prime-partition($sum, 0, $, @rest) {
  take @rest if $sum == 0;
}

#
multi prime-partition($sum, $count, $lower-bound, @rest) {
  my &finishable = { !unfinishable($sum, $count, $_) };
  my @prime-range = lazy @primes.toggle: :off, * > $lower-bound;
  @prime-range .= toggle: &finishable;
  samewith $sum - $_, $count - 1, $_, (|@rest, $_) for @prime-range;  
}

sub MAIN(
  Int $m,
  Int $n
) {
  say "Input: \$m = $m, \$n = $n";
  my $output = prime-partition($m, $n).map(*.join: ', ').join: ' or ';
  say "Output: $output";
}