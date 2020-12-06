#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use constant SUM => 15;

sub still_valid {
    my ($matrix) = @_;

  COORD:
    for my $coords ([0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
                    [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]) {
        $matrix->[$_] or next COORD for @$coords;
        return unless SUM == $matrix->[ $coords->[0] ]
                           + $matrix->[ $coords->[1] ]
                           + $matrix->[ $coords->[2] ];
    }
    return 1
}

{   my @solutions;
    sub fill {
        my ($matrix, @unused) = @_;
        unless (@unused) {
            push @solutions, [@$matrix];
            return
        }
        my $i = 0;
        ++$i until $i > $#$matrix || $matrix->[$i] == 0;
        for my $u (0 .. $#unused) {
            $matrix->[$i] = $unused[$u];
            fill($matrix, @unused[0 .. $u - 1, $u + 1 .. $#unused])
                if still_valid($matrix);
        }
        $matrix->[$i] = 0;
    }

    sub magical_matrix {
        fill([(0) x 9], 1 .. 9);
        return @solutions
    }
}

my @s = magical_matrix();
for my $m (@s) {
    say "@$m[0, 1, 2]";
    say "@$m[3, 4, 5]";
    say "@$m[6, 7, 8]";
    say "---";
}
