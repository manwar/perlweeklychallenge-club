#!/usr/bin/env perl
#
# ch-2.pl - Lonely X
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use List::Util qw< any all >;

sub X() { $_->[1] }  # Convenient aliases
sub Y() { $_->[0] }  # (syntactic sugar!)

my @ex2 = ([ qw< o o x o > ],
           [ qw< x o o o > ],
           [ qw< x o o x > ],
           [ qw< o x o o > ]);

say "There are " . lonely_x(@ex2) . " lonely 'x's";

sub lonely_x {
    my $xmax = $#{$_[0]};
    my $count = 0;

    for my $y (0..$#_) {
        for my $x (0..$xmax) {
            next if $_[$y][$x] ne 'x';

            next if any {     $_[Y][X] eq 'x'    }
                   grep {  Y >= 0 && Y <= $#_
                    and    X >= 0 && X <= $xmax  }
                    map {     [ $y+Y, $x+X ]     }
                   grep { not (X == 0 && Y == 0) }
                    map { my $yp = $_; map { [$yp,$_] } -1..1 } -1..1;

            say "x at row $y, col $x is lonely";
            $count++;
        }
    }
    $count;
}
