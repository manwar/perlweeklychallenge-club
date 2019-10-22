#!/usr/bin/perl
use warnings;
use strict;

sub line {
    my ($x1, $y1, $x2, $y2) = @_;
    my ($A, $B, $C);
    die 'Not enough points' if $x1 == $x2 && $y1 == $y2;
    if ($x1 == $x2) {
        if ($x1) {
            ($A, $B, $C) = (-1 / $x1, 0, 1);
        } else {
            ($A, $B, $C) = (1, 0, 0);
        }
    } else {
        ($A, $B, $C) = (($y2 - $y1) / ($x1 - $x2),
                        1,
                        $x1 * ($y1 - $y2) / ($x1 - $x2) - $y1);
    }
    return $A, $B, $C
}

sub intersection {
    my ($a1, $b1, $c1, $a2, $b2, $c2) = @_;
    if ($a1 * $b2 == $a2 * $b1) {
        die 'No intersection' if $c1 != $c2;
        die 'Identical lines' if $c1 == $c2;
    }
    my $y = ($a2 * $c1 - $c2 * $a1) / ($a1 * $b2 - $a2 * $b1);
    my $x = $a1 ? (-$b1 * $y - $c1) / $a1
                : (-$b2 * $y - $c2) / $a2;
    return $x, $y
}


use Test::More;
use Test::Exception;

sub point_on_line {
    my ($x1, $y1, $x2, $y2) = @_;
    my ($A, $B, $C) = line($x1, $y1, $x2, $y2);
    is $A * $x1 + $B * $y1 + $C, 0;
    is $A * $x2 + $B * $y2 + $C, 0;
}

point_on_line(3, 3, 5, 3);
point_on_line(3, 3, 3, 7);
point_on_line(1, 5, 3, 11);
throws_ok { line(1, 1, 1, 1) } qr/Not enough points/;

is_deeply [ intersection(
    line(1, 5, 3, 11),
    line(0, -1, 3, 5)
) ], [-3, -7];

is_deeply [ intersection(
    line(1, 2, 5, 14),
    line(0, 2, -1, 7)
) ], [3/8, 1/8];

is_deeply [ intersection(
    line(0, 0, 0, 1),
    line(0, 0, 1, 0)
) ], [0, 0];

is_deeply [ intersection(
    line(4.2, 19, 4.8, 22),
    line(4, 19, 3.5, 17.5)
) ], [4.5, 20.5];

is_deeply [ intersection(
    line(1, 1, 5, 1),
    line(1, 1, 1, 5),
) ], [ 1, 1 ];

throws_ok { intersection(
    line(0, 0, 1, 1),
    line(2, 2, 3, 3)
) } qr/Identical lines/;

throws_ok { intersection(
    line(2, 2, 1, 1),
    line(0, 2, 1, 3)
) } qr/No intersection/;

done_testing(14);
