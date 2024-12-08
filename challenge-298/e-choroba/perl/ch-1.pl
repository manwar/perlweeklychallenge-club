#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use experimental qw( signatures );

use List::Util qw{ min };

use enum qw( HORIZONTAL VERTICAL SQUARE );

=head1 THE ALGORITHM

Start from the upper left corner. Store 3 numbers for each cell:

1. How far we can go to the left without stepping on a 0 (HORIZONTAL);

2. How far we can go up without stepping on a 0 (VERTICAL);

3. How large square we can build leftwards and upwards (SQUARE).

Getting HORIZONTAL and VERTICAL is easy: just add 1 to the neighbour's value
in the respective direction. To get SQUARE, use 1 + SQUARE in the left-up
diagonal neighbour, but if HORIZONTAL or VERTICAL for this cell is less, use
it instead.

 1  1  1  1
 1  1  1  0
 1  1  1 (1)

 [1 1 1][2 1 1][3 1  1 ][4    1  1]
 [1 2 1][2 2 2][3 2 (2)][0    0  0]
 [1 3 1][2 3 2][3 3  3 ][(4) (1) 1]
                                 |
                                 v
                           min(2 + 1, 4, 1)]

=cut

sub maximal_square($matrix) {
    my @strips;
    my @starts;
    my $maxsize = 0;
    for my $y (0 .. $#$matrix) {
        for my $x (0 .. $#{ $matrix->[0] }) {
            if ($matrix->[$y][$x]) {
                $strips[$y][$x][HORIZONTAL]
                    = $x ? 1 + $strips[$y][ $x - 1 ][HORIZONTAL]
                         : 1;
                $strips[$y][$x][VERTICAL]
                    = $y ? 1 + $strips[ $y - 1 ][$x][VERTICAL]
                         : 1;
                $strips[$y][$x][SQUARE]
                    = ($x && $y)
                      ? min(1 + $strips[ $y - 1 ][ $x - 1 ][SQUARE],
                            @{ $strips[$y][$x] }[HORIZONTAL, VERTICAL])
                      : 1;
                $maxsize = $strips[$y][$x][SQUARE]
                    if $strips[$y][$x][SQUARE] > $maxsize;
            } else {
                $strips[$y][$x] = [0, 0, 0];
            }
        }
    }
    return $maxsize * $maxsize
}

use Test::More tests => 3 + 3;

is maximal_square([[1, 0, 1, 0, 0],
                   [1, 0, 1, 1, 1],
                   [1, 1, 1, 1, 1],
                   [1, 0, 0, 1, 0]]),
    4, 'Example 1';

is maximal_square([[0, 1],
                   [1, 0]]),
    1, 'Example 2';

is maximal_square([[0]]), 0, 'Example 3';

is maximal_square([[qw[ 0 0 0 0 0 0 0 0 0 0 0 0 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 ]]]),
    25, 'Larger';

is maximal_square([[qw[ 0 0 0 0 0 0 0 0 0 0 0 0 0 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 0 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 0 ]],
                   [qw[ 0 1 1 0 1 1 0 0 0 1 1 1 0 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 0 ]],
                   [qw[ 0 1 1 1 1 1 0 0 0 1 1 1 0 ]],
                   [qw[ 0 0 0 0 0 0 0 0 0 0 0 0 0 ]]]),
    9, 'Larger with a hole';

is maximal_square([[qw[ 0 0 1 1 0 0 0 ]],
                   [qw[ 0 0 1 1 0 0 0 ]],
                   [qw[ 0 0 0 0 0 0 0 ]],
                   [qw[ 0 0 0 0 0 0 0 ]],
                   [qw[ 0 0 0 0 0 0 0 ]],
                   [qw[ 0 0 0 0 0 0 0 ]]]),
    4, 'Bugfix';


# Check the speed:
use Time::HiRes qw{ clock };
my $SIZE = 1000;
my $t0 = clock();
my @m = map [map 0+!! int rand 10, 0 .. $SIZE], 0 .. $SIZE;
maximal_square(\@m);
say clock() - $t0, 's';  # 1.4s
