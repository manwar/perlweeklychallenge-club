#! /usr/bin/perl6

use Test;
plan 1;

is-deeply(semiprime(100),(4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39, 46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87, 91, 93, 94, 95),'example 1');

sub semiprime($mx) {
  my @primes;
  {
    my $mxx=floor($mx/2);
    my $primesh=(2..$mxx).SetHash;
    my $p=2;
    while ($p*$p <= $mxx) {
      if ($primesh{$p}:exists) {
        my $i=$p*$p;
        while ($i <= $mxx) {
          $primesh{$i}:delete;
          $i += $p;
        }
      }
      if ($p==2) {
        $p--;
      }
      $p+=2;
    }
    @primes=$primesh.keys.sort;
  }
  my $semiprimesh=SetHash();
  for 0..@primes.end -> $i {
    for $i..@primes.end -> $j {
      my $t=@primes[$i]*@primes[$j];
      if ($t <= $mx) {
        $semiprimesh{$t}++;
      } else {
        next;
      }
    }
  }
  return $semiprimesh.keys.map({$_+0}).sort;
}
