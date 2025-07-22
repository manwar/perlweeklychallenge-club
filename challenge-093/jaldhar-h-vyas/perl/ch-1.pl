#!/usr/bin/perl
use 5.038;
use warnings;
use English;

sub max(@values) {
    my $maximum = shift @values;

    while (my $next = shift @values) {
        if ($next > $maximum) {
            $maximum = $next;
        }
    }

    return $maximum;
}

my @N = @ARGV;

if (scalar @N < 1) {
    die "Usage: $PROGRAM_NAME x1,y1 x2,y2 ...\n";
}

my @points = (map { [split /,/] } @N);
my $maxPoints = 1;

for my $i (keys @points) {
    my %lines;

    for my $j (keys @points) {

        if ($i == $j) {
            next;
        }

        my ($x1, $y1) = @{$points[$i]};
        my ($x2, $y2) = @{$points[$j]};
        my ($dx, $dy) = ($x2 - $x1, $y2 - $y1);

        if ($dx == 0) {
            $lines{'inf'}++;
        } else {
            my $slope = $dy / $dx;
            my $intercept = $y1 - $slope * $x1;
            $lines{"$slope,$intercept"}++;
        }
    }

    my $localMax = (max(values %lines) // 0) + 1;

    $maxPoints = max($maxPoints, $localMax);
}

say $maxPoints;
