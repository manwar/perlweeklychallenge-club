#! /usr/bin/raku

use Test;

plan 5;

is(nearestrgb('#F4B2D1'), '#FF99CC', 'example 1');
is(nearestrgb('#15E6E5'), '#00FFCC', 'example 2');
is(nearestrgb('#191A65'), '#003366', 'example 3');
is(nearestrgb('#2D5A1B'), '#336633', 'example 4');
is(nearestrgb('#00FF66'), '#00FF66', 'example 5');

sub nearestrgb($a) {
  my $s = :16(substr($a, 1));
  my @rgb;
  for [16, 8, 0] -> $bs {
    my $cs = ($s +> $bs) +& 0xff;
    my $ct = floor($cs / 51) * 51;
    if ($cs - $ct > 25) {
      $ct += 51;
    }
    @rgb.push($ct);
  }
  sprintf('#%02X%02X%02X', @rgb[0], @rgb[1], @rgb[2]);
}
