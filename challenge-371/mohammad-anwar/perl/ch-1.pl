#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in  => [qw(a c ? g i)], out => "e" },
    { in  => [qw(a d ? j m)], out => "g" },
    { in  => [qw(a e ? m q)], out => "i" },
    { in  => [qw(a c f ? k)], out => "h" },
    { in  => [qw(b e g ? l)], out => "j" },
);

is missing_character(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub missing_character {
    my @seq  = @_;
    my @nums = map { $_ eq '?' ? undef : ord($_) - ord('a') + 1 } @seq;

    my ($x, $y);
    for (0..3) {
        if (defined $nums[$_] && defined $nums[$_ + 1]) {
            my $diff = $nums[$_ + 1] - $nums[$_];
            ($_ % 2 == 0)?($x = $diff):($y = $diff);
        }
    }

    if (!defined $x || !defined $y) {
        # Check if we can find the "other" one via a 2-step jump
        for my $i (0..2) {
            if (defined $nums[$i] && defined $nums[$i + 2]) {
                my $total = $nums[$i + 2] - $nums[$i];
                if (defined $x) {
                    $y = $total - $x;
                }
                elsif (defined $y) {
                    $x = $total - $y;
                }
                else {
                    $x = $y = $total / 2;
                }
            }
        }

        # If still missing one, the pattern is likely constant
        $x //= $y;
        $y //= $x;
    }

    # Find the '?' index and fill it
    my ($idx) = grep { !defined $nums[$_] } 0..4;
    if ($idx == 0) {
        $nums[0] = $nums[1] - $x;
    } else {
        my $step = ($idx - 1) % 2 == 0 ? $x : $y;
        $nums[$idx] = $nums[$idx - 1] + $step;
    }

    return chr($nums[$idx] + ord('a') - 1);
}
