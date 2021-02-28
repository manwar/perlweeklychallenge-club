#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

sub main {
    my ($x1, $y1, $x2, $y2, $x3, $y3) = ( join( ' ', @_ ) =~ /(-?\d+)/g );

    my $x = my $y = 0;
    my $a = (($y2 - $y3)*($x - $x3) + ($x3 - $x2)*($y - $y3)) / (($y2 - $y3)*($x1 - $x3) + ($x3 - $x2)*($y1 - $y3));
    my $b = (($y3 - $y1)*($x - $x3) + ($x1 - $x3)*($y - $y3)) / (($y2 - $y3)*($x1 - $x3) + ($x3 - $x2)*($y1 - $y3));
    my $c = 1 - $a - $b;

    my $contained = ($a >= 0 and $a <= 1 and $b >= 0 and $b <= 1 and $c >= 0 and $c <= 1) ? 1: 0;
    say $contained;
}

main (@ARGV);
