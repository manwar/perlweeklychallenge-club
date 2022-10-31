#!/usr/bin/env raku
use v6;
sub MAIN {
   put divisible-pairs(2, [4, 5, 1, 6]);
   put divisible-pairs(4, [7, 2, 4, 5]);
   put divisible-pairs(4, [7, 2, 6, 10, 1, 5, 3]);
}

sub divisible-pairs ($k, @list) {
   my %rest-for;
   for @list -> $e { %rest-for{$e % $k}++ }
   sub handshakes ($n) { (($n * ($n - 1)) / 2).Int }
   my $n = handshakes(%rest-for{0} // 0);
   for 1 .. $k / 2 -> $i {
      my $j = $k - $i;
      $n += $j == $i ?? handshakes(%rest-for{$i} // 0)
         !! (%rest-for{$i} // 0) * (%rest-for{$j} // 0);
   }
   return $n;
}
