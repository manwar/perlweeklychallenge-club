#!/usr/bin/env raku

sub seize-the-day($y,$m,$mday,$wday)
{
  my $d = Date.new(year => $y,month => $m,day => 1);
  my $diff = abs($wday - $d.day-of-week);
  $d += (7 * ($mday - 1)) + $diff;
  $d.month != $m ?? 0 !! $d.day;
}

say seize-the-day(2024,4,3,2);
say seize-the-day(2025,10,2,4);
say seize-the-day(2026,8,5,3);

