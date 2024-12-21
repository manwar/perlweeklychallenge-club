#!/usr/bin/perl

use v5.40;

use Test::More tests => 3;

sub get_beautiful_arrangements {
    my $n;
    foreach (get_permutations($_[0])) {
        ++$n if is_beautiful_arrangement(@$_);
    }
    return $n;
}

sub get_permutations {
    my $n = shift;
    my @l;
    if ($n == 1) {
        @l = ([1]);
    } else {
        foreach my $i (0..($n - 1)) {
            foreach (get_permutations($n - 1)) {
                splice @$_, $i, 0, $n;
                push @l, \@$_;
            }
        }
    }
    return @l;
}

sub is_beautiful_arrangement {
    foreach (1..($#_ + 1)) {
        return 0 unless (($_[ $_ - 1 ] % $_ == 0) or ($_ % $_[ $_ - 1 ] == 0));
    }
    return 1;
}

is(get_beautiful_arrangements(1),  1);
is(get_beautiful_arrangements(2),  2);
is(get_beautiful_arrangements(10), 700);
