#!/usr/bin/perl
use warnings;
use strict;

sub trapped_rain_water {
    my @n = @_;
    my ($volume, $left, $i) = (0) x 3;
    while (++$i <= $#n) {
        if ($n[$left] <= $n[$i]) {
            my $height = $n[$left] < $n[$i]
                       ? $n[$left]
                       : $n[$i];
            $volume += $height - $n[$_] for $left + 1 .. $i - 1;
            $left = $i;
        }
    }
    $volume += trapped_rain_water(@n[reverse $left .. $#n])
        if $n[$left] > $n[-1];
    return $volume
}

use Test::More;

is trapped_rain_water(2, 1, 4, 1, 2, 5), 6, 'Example 1';
is trapped_rain_water(3, 1, 3, 1, 1, 5), 6, 'Example 2';
is trapped_rain_water(reverse 2, 1, 4, 1, 2, 5), 6, 'Example 1 reversed';
is trapped_rain_water(reverse 3, 1, 3, 1, 1, 5), 6, 'Example 2 reversed';

is trapped_rain_water(1, 2, 3, 2, 1), 0, 'zero';

is trapped_rain_water(3, 1, 1, 2), 2, 'simple';
is trapped_rain_water(reverse 3, 1, 1, 2), 2, 'simple reversed';

is trapped_rain_water(3, 1, 2, 1, 3, 1, 2, 1, 2), 7, 'long';
is trapped_rain_water(reverse 3, 1, 2, 1, 3, 1, 2, 1, 2), 7, 'long reversed';

done_testing();
