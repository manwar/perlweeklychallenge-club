#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( sum );

my @isPrime; 
sub sieve($n) {
  # so we always have enough primes, caclulate out to 2n
  $n *= 2;
  # if we've already calculated primes this far, return
  return if $#isPrime >= $n;
  # extend the sieve to accommodate $n elements
  if ($#isPrime < $n) {
    push @isPrime, (true) x ($n - $#isPrime);
  }
  for my $i ( 2 .. int(sqrt($n))+1 ) {
    next if $isPrime[$i] == false; # already deemed not prime
    for (my $j = $i ** 2; $j <= $n; $j+=$i) {
      @isPrime[$j] = false;
    }
  }
}

sub primeStep($str) {
  my $ordsum = sum map { ord($_) } split //, $str;
  sieve($ordsum); # populate the sieve
  my $i = 0;
  do {
    return $i
      if $isPrime[$ordsum + $i] || $isPrime[$ordsum - $i];
  } until ++$i >= $ordsum;
  return -1; # we should never get here
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say 'Output: ' . primeStep($str);
}

say "Example 1:";
solution("hello");

say "\nExample 2:";
solution("football");

say "\nExample 3:";
solution("a");

say "\nExample 4:";
solution("challenge");

say "\nExample 5:";
solution("perl");
