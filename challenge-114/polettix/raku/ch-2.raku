#!/usr/bin/env raku
use v6;

sub higher-integer-set-bits (Int $N is copy) {
   sub n-bits ($x) { ($x.base(2) ~~ m:g/1/).elems };
   my $initial = n-bits($N);
   while True {
      ++$N;
      return $N if $initial == n-bits($N);
   }
}

sub MAIN (*@inputs is copy) {
   @inputs.push(3) unless @inputs.elems;
   higher-integer-set-bits($_).say for @inputs;
}
