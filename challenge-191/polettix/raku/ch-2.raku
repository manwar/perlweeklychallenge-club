#!/usr/bin/env raku
use v6;
sub MAIN (Int $n where 0 < * <= 15 = 2) { put cute-list($n) }

sub cute-list ($n) {
   sub cute-list-r ($count is copy, $i, *@items) {
      ++$count unless @items;
      my @pre;
      while @items {
         my $v = @items.shift;
         if ($v %% $i) || ($i %% $v) {
            $count = cute-list-r($count, $i + 1, @pre.Slip, @items.Slip);
         }
         @pre.push: $v;
      }
      return $count;
   };
   return cute-list-r(0, 1, 1 .. $n);
}
