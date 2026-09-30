#!/usr/bin/env raku
use v6;

my @isPrime; 
sub sieve($n is copy) {
  # so we always have enough primes, caclulate out to 2n
  $n *= 2;
  # if we've already calculated primes this far, return
  return if @isPrime.end >= $n;
  # extend the sieve to accommodate $n elements
  if (@isPrime.end < $n) {
    @isPrime.append: True xx ($n - @isPrime.elems);
  }
  for 2 .. $n.sqrt.Int+1 -> $i {
    next if @isPrime[$i] == False; # already deemed not prime
    loop (my $j = $i ** 2; $j <= $n; $j+=$i) {
      @isPrime[$j] = False;
    }
  }
}

sub primeStep($str) {
  my $ordsum = $str.comb.map({ $_.ord }).sum;
  sieve($ordsum); # populate the sieve
  my $i = 0;
  repeat {
    return $i
      if @isPrime[$ordsum + $i] || @isPrime[$ordsum - $i];
  } until ++$i >= $ordsum;
  return -1; # we should never get here
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  say 'Output: ' ~ primeStep($str);
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
