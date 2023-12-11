#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use experimental qw( signatures );

sub linear_recurrence_of_2nd_order(@a) {
    my ($p, $q);
    if (0 == $a[0]) {
        return [0, 0] if @a == grep 0 == $_, @a;
        return if 0 == $a[1];

        $q = $a[2] / $a[1];
        return unless $q == int $q;

        $p = ($a[1] * $a[3] - $a[2] ** 2) / $a[1] ** 2;

    } elsif ($a[1] ** 2 == $a[0] * $a[2]) {
        return unless $a[1] * $a[2] == $a[0] * $a[3];

        if (0 == $a[1]) {
            return unless 3 == grep 0 == $_, @a[2 .. 4];
            return [0, 0]
        }

        if ($a[2] ** 2 == $a[0] * $a[1] * $a[3]) {
            return unless $a[4] == $a[1] * $a[3];
            return [$a[1] + $a[2], -1]
        }

        $q = ($a[0] * $a[1] * $a[4] - $a[1] * $a[2] ** 2)
           / ($a[0] * $a[1] * $a[3] - $a[2] ** 2);
        return unless $q == int $q;


        $p = ($a[1] * $a[2] - $q * $a[0] * $a[2]) / ($a[0] * $a[1]);
    } else {
        $q = ($a[1] * $a[2] - $a[0] * $a[3]) / ($a[1] ** 2 - $a[0] * $a[2]);
        return unless $q == int $q;

        $p = ($a[2] - $q * $a[1]) / $a[0];
    }
    return unless $p == int $p;

    return unless $a[4] == $p * $a[2] + $q * $a[3];

    return [$p, $q]
}

use Test::More tests => 3 + 1 + 10;

ok linear_recurrence_of_2nd_order(1, 1, 2, 3, 5), 'Example 1';
ok ! linear_recurrence_of_2nd_order(4, 2, 4, 5, 7), 'Example 2';
ok linear_recurrence_of_2nd_order(4, 1, 2, -3, 8), 'Example 3';

# p = 0, a[0] is irrelevant.
ok linear_recurrence_of_2nd_order(qw( 15 1 16 256 4096 ));

ok linear_recurrence_of_2nd_order(qw( 2 4 8 16 32 ));
ok linear_recurrence_of_2nd_order(qw( -13 1 0 1 13 ));
ok linear_recurrence_of_2nd_order(qw( -12 11 -10 8 8 ));
ok linear_recurrence_of_2nd_order(qw( 1 -2 4 -8 16));
ok linear_recurrence_of_2nd_order(qw( 1 -1 1 -1 1 ));
ok linear_recurrence_of_2nd_order(qw( 3 5 8 16 0 ));
ok ! linear_recurrence_of_2nd_order(qw( 3 0 0 6 6 ));
ok ! linear_recurrence_of_2nd_order(qw( 0 -4 0 5 0 ));
ok ! linear_recurrence_of_2nd_order(qw( 0 8 8 6 4 ));
ok ! linear_recurrence_of_2nd_order(qw( 1 -1 1 -1 7 ));

#
# Extended testing.
#
# Hash all the possible sentences generated from p, q, a0, a1 in -20 .. 20.
# Then generate random sentences and verify that they're recognised correctly.
# This was great for debugging the edge cases.

sub generate($p, $q, $a0, $a1) {
    my @a = ($a0, $a1);
    $a[$_] = $p * $a[$_ - 2] + $q * $a[$_ - 1] for 2, 3, 4;
    return @a
}

my %generated;
my %i;
for my $p (-20 .. 20) {
    for my $q (-20 .. 20) {
        for my $a0 (-20 .. 20) {
            for my $a1 (-20 .. 20) {
                my @a = generate($p, $q, $a0, $a1);
                next if grep 1000 < abs, @a;

                $generated{"@a"} = "$p $q";
            }
        }
    }
}

my $c = 0;
my @a;
local $SIG{__DIE__} = sub { warn "\t@a"; exit 1 };
while (++$c < 1e7) {
    @a = map -19 + int rand 38, 0 .. 4;
    print "$c: @a          \r";
    if (exists $generated{"@a"}) {
        my $pq = linear_recurrence_of_2nd_order(@a);
        die "not ok @a (" . $generated{"@a"} . ')' unless $pq;
        my @b = generate(@$pq, @a[0, 1]);
        die "generated @a != @b (@$pq)" unless "@a" eq "@b";
    } else {
        my $pq = linear_recurrence_of_2nd_order(@a);
        if ($pq) {
            if (grep abs > 20, @$pq) {
                my @b = generate(@$pq, @a[0, 1]);
                die "!gen @a != @b (@$pq)" unless "@a" eq "@b";
            } else {
                die "not ok ! @a (@$pq)";
            }
        }
    }
}
