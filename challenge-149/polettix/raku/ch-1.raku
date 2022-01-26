#!/usr/bin/env raku
use v6;

class FibonacciSumming { ... }

sub MAIN ($N = 20) {
   my $fs = FibonacciSumming.new;
   $fs.next.put for ^$N;
}

class FibonacciSumming {
   has %!fibo = 0 => 1;
   has $!f =  0;
   has $!s = -1;
   method next () {
      while True {
         ++$!s;
         my $sum = $!s.comb(/\d/).sum;
         ($!f, %!fibo{%!fibo{$!f}}) = %!fibo{$!f}, $!f + %!fibo{$!f}
            while $!f < $sum;
         return $!s if %!fibo{$sum}:exists;
      }
   }
}
