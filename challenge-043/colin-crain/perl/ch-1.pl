#! /opt/local/bin/perl
#
#       olympics.pl
#
#       PWC 43 - TASK #1
#         Olympic Rings
#             There are 5 rings in the Olympic Logo as shown below.
#             They are color coded as in Blue, Black, Red, Yellow and Green.
#
#         ( Blue 8 )                        ( blacK )                      (  Red 9 )
#              (Blue ⋂ Yellow)  (Yellow ⋂ blacK)  (blacK ⋂ Green)  (Green ⋂ Red)
#                        ( Yellow 7 )                        ( Green 5 )
#
#             We have allocated some numbers to these rings as below:
#
#             Blue:     8
#             Yellow:   7
#             Green:    5
#             Red:      9
#             The Black ring is empty currently. You are given the numbers 1, 2,
#             3, 4 and 6. Write a script to place these numbers in the rings so
#             that the sum of numbers in each ring is exactly 11.
#
#         method: it took a bit of fidddling to understand what the challenge
#             is asking here: to place the numbers given within the empty
#             spaces of the ring diagram such that the total of all numbers
#             contained within each ring is 11. There are 9 such spaces: 5
#             rings and 4 intersections. 4 rings are assigned, leaving 5 areas
#             unassigned. We are given a list of 5 numbers, so it seems that
#             the request is one number per area (solving the puzzle by hand
#             corroborates this interpretation).
#
#             So, we can rephrase the challenge as a system of linear equations
#             to be solved:
#
#                 Blue:   8 + B⋂Y         = 11
#                 Yellow: B⋂Y + 7 + Y⋂K   = 11
#                 blacK:  Y⋂K + K + K⋂G   = 11
#                 Green:  K⋂G + 5 + G⋂R   = 11
#                 Red:    G⋂R + 9         = 11
#
#             -->     B⋂Y                         = 3
#                     B⋂Y + Y⋂K                   = 4
#                           Y⋂K + K + K⋂G         = 11
#                                     K⋂G + G⋂R   = 6
#                                           G⋂R   = 2
#
#             -->     | 1  0  0  0  0 |   | B⋂Y |   |  3 |         Ax = b form
#                     | 1  1  0  0  0 |   | Y⋂K |   |  4 |
#                     | 0  1  1  1  0 | . |  K  | = | 11 |
#                     | 0  0  0  1  1 |   | K⋂G |   |  6 |
#                     | 0  0  0  0  1 |   | G⋂R |   |  2 |
#
#               and we solve:
#               Ax = b
#               --> (A-1) • A • x = (A-1) • b
#               --> I • x = (A-1) • b
#               --> (A-1) • b = x
#
#               We generate the inverse of A and plug in to find x, vector of
#               the solution.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

use Math::MatrixReal;

my $a = Math::MatrixReal->new_from_string(<<MATRIX);
[ 1 0 0 0 0 ]
[ 1 1 0 0 0 ]
[ 0 1 1 1 0 ]
[ 0 0 0 1 1 ]
[ 0 0 0 0 1 ]
MATRIX

my $b = Math::MatrixReal->new_from_string(<<MATRIX);
[ 3  ]
[ 4  ]
[ 11 ]
[ 6  ]
[ 2  ]
MATRIX

my $LR = $a->decompose_LR();
my ($dim, $out, $base) = $LR->solve_LR($b);

say "there is only one solution:\n" if $dim == 0;

my @values = qw(Blue-Yellow Yellow-Black Black Black-Green Green-Red);
my @solution = $out->as_list;
printf "%-12s = %d\n", $_, (shift @solution) for @values;
