#!/usr/bin/perl

# You are given an array representing box coins, @box.  Write a script to
# collect the maximum coins until you took out all boxes.  If we pick box[i]
# then we collect the coins $box[i-1] * $box[i] * $box[i+1].  If $box[i+1] or
# $box[i-1] is out of bound then treat it as 1 coin.

use 5.036;
use utf8;

use List::Util qw(product);

sub collect_coins ($steps, @box) {
    my $size = scalar @box;

    if ($size == 0) {
        return 0;
    }

    if ($size == 1) {
        my $coins = [1, $box[0], 1];
        push @{$steps}, {index => 0, coins => $coins};
        return $box[0];
    }

    my $total      = 0;
    my $best_steps = [];
    for (my $i = 0; $i < $size; $i++) {
        my $coins;
        if ($i == 0) {
            $coins = [1, $box[0], $box[1]];
        }
        elsif ($i + 1 == $size) {
            $coins = [$box[$i - 1], $box[$i], 1];
        }
        else {
            $coins = [$box[$i - 1], $box[$i], $box[$i + 1]];
        }

        my $current_steps = [{index => $i, coins => $coins}];

        my @rest = @box;
        splice @rest, $i, 1;
        my $n = product(@{$coins}) + collect_coins($current_steps, @rest);
        if ($total < $n) {
            $total      = $n;
            $best_steps = $current_steps;
        }
    }
    push @{$steps}, @{$best_steps};
    return $total;
}

sub box_coins (@box) {
    my $steps = [];
    my $total = collect_coins($steps, @box);
    return wantarray ? ($total, $steps) : $total;
}

sub print_box_coins (@box) {
    my ($total, $steps) = box_coins(@box);
    printf "Input:  \@box = (%s)\n", join ', ', @box;
    printf "Output: %d\n", $total;
    my $step_number = 1;
    for my $step (@{$steps}) {
        my $index = $step->{index};
        my @coins = @{$step->{coins}};
        printf "Step %d: pick box [i=%d] and collect coins %s => %d\n",
            $step_number, $index, join(' * ', @coins), product @coins;
        $step_number++;
    }
    return;
}

print_box_coins(3, 1, 5, 8);
print "\n";
print_box_coins(1, 5);
print "\n";
print_box_coins(3, 8, 6, 9, 2, 4, 5, 9, 2);
