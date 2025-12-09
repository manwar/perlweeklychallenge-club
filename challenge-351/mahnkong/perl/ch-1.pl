use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my %helper;
    foreach my $i (@ints) {
        $helper{$i} = undef;
    }
    my @sorted = sort(keys(%helper));

    return 0 if scalar(@sorted) < 3;

    my $sum = 0;
    for (my $i = 1; $i < scalar(@sorted) - 1; $i++) {
        $sum += $sorted[$i];
    }
    return $sum / (scalar(@sorted) - 2);
}

is(run(8000, 5000, 6000, 2000, 3000, 7000), 5250, "Example 1");
is(run(100_000, 80_000, 110_000, 90_000), 95_000, "Example 2");
is(run(2500, 2500, 2500, 2500), 0, "Example 3");
is(run(2000), 0, "Example 4");
is(run(1000, 2000, 3000, 4000, 5000, 6000), 3500, "Example 5");
