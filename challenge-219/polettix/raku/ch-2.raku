#!/usr/bin/env raku
use v6;
sub MAIN (*@days is copy) {
   put travel-expenditure(@days.splice(0, 3), @days);
}

sub travel-expenditure (@costs, @days) {
   state @spans = 1, 7, 30;
   state %cache;
   return 0 unless @days;
   my $key = @days.join(',');
   %cache{$key} //= (@costs Z @spans).map(-> ($cost, $span) {
      my ($first, @pool) = @days;
      @pool.shift while @pool && @pool[0] < $first + $span;
      $cost + samewith(@costs, @pool);
   }).min;
}
