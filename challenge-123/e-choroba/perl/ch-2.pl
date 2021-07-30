#!/usr/bin/perl
use warnings;
use strict;

sub draw {
    my @c = @_;
    my %extreme = (x => {min => $c[0][0], max => $c[0][0]},
                   y => {min => $c[0][1], max => $c[0][1]});
    for (@c) {
        $extreme{x}{min} = $_->[0] if $_->[0] < $extreme{x}{min};
        $extreme{x}{max} = $_->[0] if $_->[0] > $extreme{x}{max};
        $extreme{y}{min} = $_->[1] if $_->[1] < $extreme{y}{min};
        $extreme{y}{max} = $_->[1] if $_->[1] > $extreme{y}{max};
    }
    my %p; @p{ map "@$_", @c } = ();
    for my $x ($extreme{x}{min} - 1 .. $extreme{x}{max} + 1) {
        print "#\t";
        for my $y ($extreme{y}{min} - 1 .. $extreme{y}{max} + 1) {
            print exists $p{"$x $y"} ? 'X ' : '. ';
        }
        print "\n";
    }

}

sub is_square {
    my %coords = @_;
    my @sorted_coords = sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] }
                        map [$coords{"x$_"}, $coords{"y$_"}], 1 .. 4;
    draw(@sorted_coords);

    my @vectors = map [$sorted_coords[ $_->[0] ][0]
                       - $sorted_coords[ $_->[1] ][0],
                       $sorted_coords[ $_->[0] ][1]
                       - $sorted_coords[ $_->[1] ][1]],
                 [0, 1], [1, 3], [3, 2], [2, 0];

    my @diagonals = map [$sorted_coords[ $_->[0] ][0]
                         - $sorted_coords[ $_->[1] ][0],
                         $sorted_coords[ $_->[0] ][1]
                         - $sorted_coords[ $_->[1] ][1]],
                    [0, 3], [1, 2];

    # All vectors have the same size.
    my %size;
    ++$size{ $_->[0] ** 2 + $_->[1] ** 2 } for @vectors;
    return unless 1 == keys %size;

    # No duplicate points.
    return if grep $_->[0] == 0 && $_->[1] == 0, @vectors;

    # No rhombi.
    abs $diagonals[0][$_] == abs $diagonals[1][ ! $_ ]
        or return
        for 0, 1;

    return 1
}

use Test::More;

ok is_square(x1 => 10, y1 => 20,
             x2 => 20, y2 => 20,
             x3 => 20, y3 => 10,
             x4 => 10, y4 => 10), 'Example 1';

ok ! is_square(x1 => 12, y1 => 24,
               x2 => 16, y2 => 10,
               x3 => 20, y3 => 12,
               x4 => 18, y4 => 16), 'Example 2';

# Some more:

ok is_square(x1 => 3, y1 => 3,
             x2 => 5, y2 => 5,
             x3 => 3, y3 => 5,
             x4 => 5, y4 => 3), 'Horizontal';

ok is_square(x1 => 3, y1 => 3,
             x2 => 4, y2 => 4,
             x3 => 3, y3 => 4,
             x4 => 4, y4 => 3), 'Smallest';

ok is_square(x1 =>  1, y1 =>  3,
             x2 =>  3, y2 =>  1,
             x3 => -1, y3 =>  1,
             x4 =>  1, y4 => -1), 'Diagonal';

ok is_square(x1 => -1, y1 => -1,
             x2 =>  2, y2 => -2,
             x3 =>  3, y3 =>  1,
             x4 =>  0, y4 =>  2), 'Askew clockwise';

ok is_square(x1 => 2, y1 => 3,
             x2 => 5, y2 => 5,
             x3 => 4, y3 => 0,
             x4 => 7, y4 => 2), 'Askew counterclockwise';

ok ! is_square(x1 =>  0, y1 =>  3,
               x2 =>  0, y2 => -3,
               x3 =>  1, y3 =>  0,
               x4 => -1, y4 =>  0), 'Diamond';

ok ! is_square(x1 => 4, y1 => 9,
               x2 => 4, y2 => 8,
               x3 => 4, y3 => 9,
               x4 => 3, y4 => 9), 'Double Point';

ok ! is_square(x1 => 0, y1 => 0,
               x2 => 0, y2 => 0,
               x3 => 1, y3 => 1,
               x4 => 1, y4 => 1), 'Two double points';

ok ! is_square(x1 => 0, y1 => 0,
               x2 => 0, y2 => 0,
               x3 => 0, y3 => 0,
               x4 => 1, y4 => 1), 'Triple point';

ok ! is_square(x1 => 0, y1 => 0,
               x2 => 0, y2 => 0,
               x3 => 0, y3 => 0,
               x4 => 0, y4 => 0), 'Quadruple point';

ok ! is_square(x1 => 2, y1 => 4,
               x2 => 1, y2 => 5,
               x3 => 4, y3 => 5,
               x4 => 2, y4 => 7), 'Isosceles Trapezium';

done_testing();

__END__

# I used the following to test my code, if the code is correct, the
# last shape should always be a square.

while (1) {
    my @c = map int rand 10, 1 .. 8;
    print "@c\n";
    if (is_square(x1 => $c[0], y1 => $c[1],
                  x2 => $c[2], y2 => $c[3],
                  x3 => $c[4], y3 => $c[5],
                  x4 => $c[6], y4 => $c[7])
    ) {
        last
    }
}
