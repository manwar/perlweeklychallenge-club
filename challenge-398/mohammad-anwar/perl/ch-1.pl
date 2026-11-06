#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => [18, 5, 7, 11],          out => 18 },
    { in => [6, 12, 18, 24, 30, 40], out => 18 },
    { in => [3, 9, 15, 21, 27],      out => 0  },
    { in => [6, 12, 14, 20],         out => 9  },
    { in => [6, 6, 6, 12, 12],       out => 8  },
);

is divisible_average(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub divisible_average(@arr) {
    my @filtered = grep { $_ % 6 == 0 } @arr;
    return 0 unless @filtered;

    my $sum = 0;
    $sum += $_ for @filtered;

    return int($sum / @filtered + 0.5);
}
