#!/usr/bin/perl
use 5.030;
use warnings;

sub all {
    my ($arr, $val) = @_;

    for my $elem (@{$arr}) {
        if ($elem != $val) {
            return undef;
        }
    }
    return 1;
}

sub sum {
    my ($arr) = @_;
    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

sub isEvenlyDivisible {
    my ($arr) = @_;

    return sum($arr) % (scalar @{$arr}) == 0;
}

my @n = @ARGV;

my $moves;

if (!isEvenlyDivisible(\@n)) {
    $moves = -1;
} else {

    my $balance = sum(\@n) / scalar @n;
    my $end = scalar @n - 1;

    until (all(\@n, $balance)) {
        for my $i (0 .. $end) {
            if ($n[$i] == 0) {
                next;
            }
            elsif ($n[$i] < $balance) {
                if ($i > 0 && $n[$i - 1] > $n[$i]) {
                    $n[$i - 1]--;
                    $n[$i]++;
                    $moves++;
                }

                if ($i < $end && $n[$i + 1] > $n[$i]) {
                    $n[$i + 1]--;
                    $n[$i]++;
                    $moves++;
                }
            }
            elsif ($n[$i] > $balance) {
                if ($i > 0 && $n[$i - 1] < $n[$i]) {
                    $n[$i - 1]++;
                    $n[$i]--;
                    $moves++;
                }

                if ($i < $end && $n[$i + 1] < $n[$i]) {
                    $n[$i + 1]++;
                    $n[$i]--;
                    $moves++;
                }
            }
        }
    }
}

say $moves;
