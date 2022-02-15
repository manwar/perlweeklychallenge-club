#!/usr/bin/perl
use warnings;
use strict;

# First point is the lower left, second point is the upper right.
sub canonical_rect {
    my ($rect) = @_;
    my ($point1, $point2) = @$rect;
    my @x = sort { $a <=> $b } map $_->[0], $point1, $point2;
    my @y = sort { $a <=> $b } map $_->[1], $point1, $point2;
    return [[$x[0], $y[0]], [$x[1], $y[1]]]
}

sub area {
    my ($r) = @_;
    return ($r->[1][0] - $r->[0][0]) * ($r->[1][1] - $r->[0][1])
}

sub overlap {
    my ($r1, $r2) = @_;

    my ($point1, $point2) = ([], []);

    for my $i (0, 1) {
        ($r1, $r2) = ($r2, $r1) if $r1->[0][$i] > $r2->[0][$i];
        return 0 unless $r2->[0][$i] < $r1->[1][$i]
                     && $r2->[1][$i] > $r1->[0][$i];

        push @$point1, $r2->[0][$i];
        push @$point2, (($r1->[1][$i] < $r2->[1][$i]) ? $r1 : $r2)->[1][$i];
    }

    return area([$point1, $point2])
}

sub rectangle_area {
    my ($r1, $r2) = @_;
    $_ = canonical_rect($_) for $r1, $r2;
    return area($r1) + area($r2) - overlap($r1, $r2)
}

# Count every square in both the rectangles.
sub rectangle_area_naive {
    my ($r1, $r2) = @_;

    my %grid;
    for my $r ($r1, $r2) {
        my @xs = $r->[0][0] < $r->[1][0]
               ? $r->[0][0] .. $r->[1][0] - 1
               : $r->[1][0] .. $r->[0][0] - 1;
        for my $x (@xs) {
            my @ys = $r->[0][1] < $r->[1][1]
                   ? $r->[0][1] .. $r->[1][1] - 1
                   : $r->[1][1] .. $r->[0][1] - 1;
            for my $y (@ys) {
                undef $grid{"$x $y"};
            }
        }
    }
    return scalar keys %grid
}

use Test::More tests => 35;

is_deeply canonical_rect([[1, 2], [3, 4]]), [[1, 2], [3, 4]], 'cannonical 1';
is_deeply canonical_rect([[3, 4], [1, 2]]), [[1, 2], [3, 4]], 'cannonical 2';
is_deeply canonical_rect([[1, 4], [3, 2]]), [[1, 2], [3, 4]], 'cannonical 3';
is_deeply canonical_rect([[3, 2], [1, 4]]), [[1, 2], [3, 4]], 'cannonical 4';

is area([[0, 0], [3, 3]]), 9, 'area 1';
is area([[1, 2], [4, 5]]), 9, 'area 2';

is overlap(map canonical_rect($_), [[-1,  0], [2, 2]], [[ 0, -1], [4, 4]]),
    4, 'overlap 1';
is overlap(map canonical_rect($_), [[-3, -1], [1, 3]], [[-1, -3], [2, 2]]),
    6, 'overlap 2';

is rectangle_area([[-1,  0], [2, 2]], [[ 0, -1], [4, 4]]), 22, 'Example 1';
is rectangle_area([[-3, -1], [1, 3]], [[-1, -3], [2, 2]]), 25, 'Example 2';

for (1 .. 25) {
    my @points = map [-50 + int rand 100, -50 + int rand 100], 1 .. 4;
    is rectangle_area([@points[0, 1]], [@points[2, 3]]),
        rectangle_area_naive([@points[0, 1]], [@points[2, 3]]),
        "same $_";
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    fast => 'rectangle_area([[-20, -15], [10, 15]], [[-5, -2], [7, 9]])',
    naive => 'rectangle_area_naive([[-20, -15], [10, 15]], [[-5, -2], [7, 9]])',
});

__END__

          Rate naive  fast
naive   2625/s    --  -98%
fast  121457/s 4527%    --
