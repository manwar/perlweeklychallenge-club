#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => [[2],[4]],               out => 3.0  },
    { in => [[1,2,3],[7,8,9,10]],    out => 7.0  },
    { in => [[],[10,20,30,40]],      out => 25.0 },
    { in => [[100],[1,2,3,4,5,6,7]], out => 4.5  },
    { in => [[1,2,2],[2,2,3]],       out => 2.0  },
);

is median($_->{in}), $_->{out} foreach @examples;

done_testing;

sub median ($in) {
    my @m   = sort { $a <=> $b } map { @$_ } @$in;
    my $mid = @m >> 1;
    return @m % 2 ? $m[$mid] : ($m[$mid - 1] + $m[$mid]) / 2;
}
