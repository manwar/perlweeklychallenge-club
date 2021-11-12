#!/usr/bin/env raku
use v6;

subset FullyGregorianYear of Int where * > 1582;
sub is-long-year (FullyGregorianYear:D $y) {
   my $dow = Date.new($y, 1, 1).day-of-week;
   return $dow == 4 || $dow == 3 && Date.new($y, 12, 31).day-of-week == 4;
}

my @longs = (1900 .. 2100).grep({is-long-year($_)});
while @longs > 0 {
   my @slice = @longs.splice(0, 5);
   @slice.push: '' if @slice == 5;
   @slice.join(', ').put;
}
