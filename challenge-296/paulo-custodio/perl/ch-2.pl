#!/usr/bin/env perl

# Perl Weekly Challenge 296 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-296/

use Modern::Perl;
use List::Util qw(sum);

@ARGV or die "usage: $0 nums...\n";
say can_make_square(@ARGV) ? "true" : "false";

sub can_make_square {
    my @sticks = sort { $b <=> $a } @_;   # largest first
    my $sum = sum(@sticks);

    return 0 if $sum % 4 != 0;  # must use all sticks
    my $side = $sum / 4;

    return 0 if $sticks[0] > $side;

    my @sides = (0, 0, 0, 0);

    my $dfs;   # declare first so recursion works
    $dfs = sub {
        my ($i) = @_;
        return 1 if $i == @sticks;   # all sticks placed

        my $len = $sticks[$i];

        for my $s (0..3) {
            next if $sides[$s] + $len > $side;

            # symmetry pruning: skip identical states
            next if $s > 0 && $sides[$s] == $sides[$s-1];

            $sides[$s] += $len;
            return 1 if $dfs->($i+1);
            $sides[$s] -= $len;

            # if we tried an empty side and failed, don't try other empty sides
            last if $sides[$s] == 0;
        }

        return 0;
    };

    return $dfs->(0);
}
