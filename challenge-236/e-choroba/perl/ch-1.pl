#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub exact_change(@bills) {
    my %change = map +($_ => 0), 5, 10;
    for my $bill (@bills) {
        if ($bill == 10) {
            return unless $change{5}--;

        } elsif ($bill == 20) {
            # First try to return 10 + 5, we might need 5s later.
            if ($change{10} && $change{5}) {
                --$change{$_} for 5, 10;
            } elsif ($change{5} > 2) {
                $change{5} -= 3;
            } else {
                return
            }
            next  # 20s are never returned.
        }

        ++$change{$bill};
    }
    return 1
}

use Test::More tests => 3 + 1;

ok exact_change(5, 5, 5, 10, 20), 'Example 1';
ok ! exact_change(5, 5, 10, 10, 20), 'Example 2';
ok exact_change(5, 5, 5, 20), 'Example 3';

ok exact_change(5, 5, 5, 5, 10, 20, 10), 'Keep the fives';
