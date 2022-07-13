#!/usr/bin/env raku
use v6;

class sylvester-sequence { ... };
sub MAIN (Int:D $count = 10) {
   my $ssq = sylvester-sequence.new();
   put $ssq.next for 1 .. $count;
}

class sylvester-sequence {
   has $!n;
   method next { $!n = $!n ?? 1 + $!n * ($!n - 1) !! 2 }
}
