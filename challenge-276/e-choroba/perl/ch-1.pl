#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# Optimised solution, much faster for large input arrays.
sub complete_day(@hours) {
    my %modulo24;
    ++$modulo24{ $_ % 24 } for @hours;
    my $tally = 0;
    for my $x (1 .. 11) {
        $tally += ($modulo24{$x} // 0) * ($modulo24{ 24 - $x } // 0);
    }
    for my $x (0, 12) {
        $tally += ($modulo24{$x} ** 2 - $modulo24{$x}) / 2
            if exists $modulo24{$x};
    }
    return $tally
}

sub complete_day_simple(@hours) {
    my $tally = 0;
    for my $i (0 .. $#hours - 1) {
        for my $j ($i + 1 .. $#hours) {
            ++$tally if ($hours[$i] + $hours[$j]) % 24 == 0;
        }
    }
    return $tally
}

use Test::More tests => 3 + 7 + 1001;

is complete_day(12, 12, 30, 24, 24), 2, 'Example 1';
is complete_day(72, 48, 24, 5), 3, 'Example 2';
is complete_day(12, 18, 24), 0, 'Example 3';

is complete_day(1 .. 23), 11, '1..23';
is complete_day(12, 1 .. 23), 12, '12, 1..23';
is complete_day(1 .. 36), 23, '1..36';
is complete_day(1 .. 37), 25, '1..37 (introduce 72)';
is complete_day(1 .. 47), 45, '1..47';
is complete_day(1 .. 60), 70, '1..60';
is complete_day(1 .. 61), 73, '1..61 (introduce 96)';

for (1 .. 1000) {
    my @hours = map int rand 100, 1 .. 10 + rand 100;
    is complete_day(@hours), complete_day_simple(@hours), "same $_";
}

use Benchmark qw{ cmpthese };

my @hours = map int rand 100, 1 .. 10 + rand 100;
is complete_day(@hours), complete_day_simple(@hours), "same bench (@hours)";

cmpthese(-3, {
    simple    => sub { complete_day_simple(@hours) },
    optimised => sub { complete_day(@hours) },
});
