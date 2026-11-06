#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [18, 5, 7, 11],          out => 18 },
    { in => [6, 12, 18, 24, 30, 40], out => 18 },
    { in => [3, 9, 15, 21, 27],      out => 0  },
    { in => [6, 12, 14, 20],         out => 9  },
    { in => [6, 6, 6, 12, 12],       out => 8  },
);

for @examples -> $ex {
    is divisible-average($ex<in>), $ex<out>;
}

done-testing;

sub divisible-average(@arr) {
    my @filtered = @arr.grep({ $_ % 6 == 0 });
    return 0 unless @filtered;

    my $sum = 0;
    $sum += $_ for @filtered;

    return (($sum / @filtered) + 0.5).Int;
}
