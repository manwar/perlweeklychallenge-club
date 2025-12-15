#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util qw/min max sum/;

my @examples = (
    { in => [8000, 5000, 6000, 2000, 3000, 7000], out => 5250   },
    { in => [100_000, 80_000, 110_000, 90_000],   out => 95_000 },
    { in => [2500, 2500, 2500, 2500],             out => 0      },
    { in => [2000],                               out => 0      },
    { in => [1000, 2000, 3000, 4000, 5000, 6000], out => 3500   },
);

is(special_average(@{$_->{in}}), $_->{out}) for @examples;

done_testing;

sub special_average {
    my @nums = @_;
    return 0 unless @nums;

    my $min = min @nums;
    my $max = max @nums;

    my @filtered = grep { $_ != $min && $_ != $max } @nums;
    return 0 unless @filtered;

    my $sum = sum @filtered;

    return $sum / @filtered;
}
