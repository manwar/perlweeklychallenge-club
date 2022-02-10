#!/usr/bin/env raku
use v6;

class FibonacciWords { ... };

sub MAIN (Int:D $a, Int:D $b where $b.Str.chars == $a.Str.chars) {
   my $it = FibonacciWords.new($a, $b);
   put "Fibonacci Words\n";
   loop {
      my $item = $it.next();
      put "'$item'";
      if $item.chars >= 51 {
         my $digit = $item.substr(50, 1);
         put "\nThe 51st digit in the first term having at least 51 digits '$item' is $digit.";
         last;
      }
   }
}

class FibonacciWords {
   has $!f0 is built;
   has $!f1 is built;
   has $!backlog = 2;
   method new (Str() $f0, Str() $f1) { self.bless(:$f0, :$f1) }
   method next () {
      if ! $!backlog {
         ($!f0, $!f1) = ($!f1, $!f0 ~ $!f1);
         return $!f1;
      }
      --$!backlog;
      return $!backlog ?? $!f0 !! $!f1;
   }
}
