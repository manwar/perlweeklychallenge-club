#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum first };

sub flip_array {
    my @arr = @_;
    my %best = (flip_tally => 0, sum => sum(@arr));
    my @signs = (1) x @arr;
    $signs[-1] = -1;
  INDICATOR:
    while (1) {
        my $sum = sum(map $arr[$_] * $signs[$_], 0 .. $#arr);
        %best = (flip_tally => scalar(grep $_ == -1, @signs), sum => $sum)
            if $sum < $best{sum} && $sum > 0;
        my $last_flip = $#signs;

        while ($signs[$last_flip] == -1) {
            $signs[$last_flip] = 1;
            --$last_flip;
            last INDICATOR if $last_flip < 0;
        }
        $signs[$last_flip] = -1;
    }
    return $best{flip_tally}
}

sub flip_array_dp {  # DP stands for Dynamic Programming
    my @arr = @_;
    my %sums = (0 => 0);
    my %best;
    for my $element (@arr) {
        my %next;
        for my $sum (keys %sums) {
            for my $multiply_add ([1, 0], [-1, 1]) {
                my $new_sum = $sum + $element * $multiply_add->[0];
                my $new_flip_tally = $sums{$sum} + $multiply_add->[1];
                $next{$new_sum} = $new_flip_tally
                    if ! exists $next{$new_sum}
                    || $next{$new_sum} > $new_flip_tally;
            }
        }
        %sums = %next;
    }
    my $best = first { $_ > 0 } keys %sums;
    for my $sum (keys %sums) {
        $best = $sum if $sum > 0 && $sum < $best;
    }
    return $sums{$best}
}

use Test::More tests => 7;

is flip_array(3, 10, 8), 1, 'Example 1';
is flip_array(12, 2, 10), 1, 'Example 2';
is flip_array(1 .. 20), 6, 'long';
# Uncomment if you want to wait for years.
# is flip_array_dp(1 .. 100), 30, 'very long';

is flip_array_dp(3, 10, 8), 1, 'Example 1';
is flip_array_dp(12, 2, 10), 1, 'Example 2';
is flip_array_dp(1 .. 20), 6, 'long';
is flip_array_dp(1 .. 100), 30, 'very long';

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive => sub { flip_array(15 .. 30) },
    dp    => sub { flip_array_dp(15 .. 30) },
});

__END__
        Rate naive    dp
naive 5.18/s    --  -98%
dp     268/s 5068%    --
