#!/usr/bin/perl
use 5.038;
use warnings;

sub max(@arr) {
    my $highest = '-inf';
    for my $i (@arr) {
        if ($i > $highest) {
            $highest = $i;
        }
    }

    return $highest;
}

sub min(@arr) {
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

my ($rect1, $rect2) = @ARGV;

my ($x1a, $y1a, $x2a, $y2a) = split /,/, $rect1;
my ($x1b, $y1b, $x2b, $y2b) = split /,/, $rect2;

my $area1 = ($x2a - $x1a) * ($y2a - $y1a);
my $area2 = ($x2b - $x1b) * ($y2b - $y1b);

my $overlapx1 = max($x1a, $x1b);
my $overlapy1 = max($y1a, $y1b);
my $overlapx2 = min($x2a, $x2b);
my $overlapy2 = min($y2a, $y2b);

my $overlapArea = 0;
if ($overlapx2 > $overlapx1 && $overlapy2 > $overlapy1) {
    $overlapArea =
        ($overlapx2 - $overlapx1) * ($overlapy2 - $overlapy1);
}

say $area1 + $area2 - $overlapArea;