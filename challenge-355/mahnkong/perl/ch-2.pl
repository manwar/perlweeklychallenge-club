use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    return 0 if scalar(@ints) < 3;
    my @switches;
    for (my $i = 1; $i < scalar(@ints); $i++) {
        return 0 if ($ints[$i-1] == $ints[$i]);
        if ($ints[$i-1] < $ints[$i] && (!scalar(@switches) || $switches[-1] ne 'up')) {
            push @switches, 'up';
        } elsif ($ints[$i-1] > $ints[$i] && (!scalar(@switches) || $switches[-1] ne 'down')) {
            push @switches, 'down';
        }
    }
    return 0 if scalar(@switches) != 2;
    return 1 if $switches[0] eq 'up' && $switches[1] eq 'down';
}

ok(!run(1, 2, 3, 4, 5), 'Example 1');
ok(run(0, 2, 4, 6, 4, 2, 0), 'Example 2');
ok(!run(5, 4, 3, 2, 1), 'Example 3');
ok(!run(1, 3, 5, 5, 4, 2), 'Example 4');
ok(run(1, 3, 2), 'Example 5');
