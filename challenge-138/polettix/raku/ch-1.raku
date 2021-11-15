#!/usr/bin/env raku
use v6;

subset FullyGregorianYear of Int where * > 1582;
sub workdays (FullyGregorianYear $y) {
   my $bdow = Date.new($y, 1, 1).day-of-week;
   my $edow = Date.new($y, 12, 31).day-of-week;
   my $bdays = 8 - $bdow; # 1 - 7
   my $ydays = 365 + ($bdow == $edow ?? 0 !! 1) - $bdays - $edow;
   return max($bdays - 2, 0) + ($ydays / 7 * 5).Int + min($edow, 5);
}

sub MAIN (FullyGregorianYear $y = 2021) { workdays($y).put }
