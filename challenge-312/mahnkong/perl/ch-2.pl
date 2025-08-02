use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str) {
    my %boxes;
    while ($str =~ /([GBR]{1})(\w{1})/g) {
        $boxes{$2}->{$1} = undef;
    }

    foreach my $box (keys %boxes) {
        delete $boxes{$box} unless (scalar(keys(%{$boxes{$box}})) == 3);
    }
    return scalar(keys(%boxes));
}

is(run("G0B1R2R0B0"), 1, "Example 1");
is(run("G1R3R6B3G6B1B6R1G3"), 3, "Example 2");
is(run("B3B2G1B3"), 0, "Example 3");
