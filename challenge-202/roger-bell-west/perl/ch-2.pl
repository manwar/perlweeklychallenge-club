#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(widestvalley([1, 5, 5, 2, 8]), [5, 5, 2, 8], 'example 1');
is_deeply(widestvalley([2, 6, 8, 5]), [2, 6, 8], 'example 2');
is_deeply(widestvalley([9, 8, 13, 13, 2, 2, 15, 17]), [13, 13, 2, 2, 15, 17], 'example 3');
is_deeply(widestvalley([2, 1, 2, 1, 3]), [2, 1, 2], 'example 4');
is_deeply(widestvalley([1, 3, 3, 2, 1, 2, 3, 3, 2]), [3, 3, 2, 1, 2, 3, 3], 'example 5');

sub widestvalley($a) {
    my @av;
    my @ac;
    my $l = -1;
    foreach my $v (@{$a}) {
        if ($v == $l) {
            $ac[-1]++;
        } else {
            push @av, $v;
            push @ac, 1;
            $l = $v;
        }
    }
    my @s;
    my @e;
    my $c = 0;
    foreach my $i (0..$#av) {
        if ($i == 0 || $i == $#av || ($av[$i - 1] < $av[$i] && $av[$i] > $av[$i + 1])) {
            push @s, $c;
            push @e, $c + $ac[$i] - 1;
        }
        $c += $ac[$i];
    }
    my @out;
    foreach my $i (0..$#s - 1) {
        if ($e[$i + 1] - $s[$i] + 1 > scalar @out) {
            @out = @{$a}[$s[$i]..$e[$i + 1]];
        }
    }
    return \@out;
}
