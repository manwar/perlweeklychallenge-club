#!/usr/bin/env perl

use 5.36.0;

# The 20th number takes a huge amount of time and requires bigint
# which sadly slows it down further. So since we want 19 only...
use integer;

#
# power_cache ($d, $n)
#
# $d: number we want to exponentiate
# $n: exponent
#
# returns $d^$n and caches the value. exponentiation is carried out by
# repeated multiplication with the nearest exponent that is already
# cached

sub power_cache ($d, $n) {

  state $cache = {};

  if ($$cache {$d} [$n]) {

    # cache hit
    return $$cache {$d} [$n];
  }
  elsif (($n == 1) || ($d <= 1)) {

    # trivial exponentiation
    return ($$cache {$d} [$n] = $d);
  }
  else {

    # recurse!
    return ($$cache {$d} [$n] = $d * power_cache ($d, $n - 1));
  }
}

my $MAX = 19;
my $this = 0;
my @d_numbers;

while (@d_numbers < $MAX) {

  my @digits = split //, $this;

  my $d_sum = 0;
  $d_sum += power_cache (int $digits [$_], int $_ + 1)
    for (0 .. $#digits);

  if ($this == $d_sum) {
    push @d_numbers, $this;
    say scalar (@d_numbers) . " Found $this";
  }

  ++$this;
}
