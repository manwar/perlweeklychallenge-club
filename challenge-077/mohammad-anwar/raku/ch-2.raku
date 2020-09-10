#!/usr/bin/env raku

#
# Perl Weekly Challenge - 077
#
# Task #2: Lonely X
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/
#

use v6.d;

sub MAIN(Int :$R is copy where { $R >= 2 } = 3,
         Int :$C is copy where { $C >= 2 } = 3) {

    my $matrix = get-matrix(--$R, --$C);
    find-lonely-x($matrix).say;
}

#
#
# METHODS

sub find-lonely-x($matrix) {

    my $rows = $matrix.elems - 1;
    my $cols = $matrix.[0].elems - 1;

    my @lonely_x = ();
    for 0..$rows -> $row {
        for 0..$cols -> $col {
            next unless $matrix.[$row][$col] eq 'X';

            my @neighbours = ();

            # top
            @neighbours.push: $matrix.[$row-1][$col] if $row > 0;
            # bottom
            @neighbours.push: $matrix.[$row+1][$col] if $row < $rows;

            # left
            @neighbours.push: $matrix.[$row][$col-1]   if $col > 0;
            # diagonal top left
            @neighbours.push: $matrix.[$row-1][$col-1] if $row > 0     && $col > 0;
            # diagonal bottom left
            @neighbours.push: $matrix.[$row+1][$col-1] if $row < $rows && $col > 0;

            # right
            @neighbours.push: $matrix.[$row][$col+1]   if $col < $cols;
            # diagonal top right
            @neighbours.push: $matrix.[$row-1][$col+1] if $row > 0     && $col < $cols;
            # diagonal bottom right
            @neighbours.push: $matrix.[$row+1][$col+1] if $row < $rows && $col < $cols;

            unless @neighbours.grep({ /X/ }) {
               @lonely_x.push: ($row+1, $col+1);
            }
        }
    }

    return 0 if @lonely_x.elems == 0;
    return |@lonely_x;
}

sub get-matrix(Int $rows where { $rows >= 1 },
               Int $cols where { $cols >= 1 }) {

    my $min   = 0;
    my $max   = 9;
    my $array = [ 'X', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 'X', 'O' ];

    my $matrix  = [];
    for 0..$rows -> $r {
        for 0..$cols -> $c {
            $matrix.[$r][$c] = $array.pick;
        }
    }

    display-matrix('Matrix:', $matrix);
    return $matrix;
}

sub display-matrix($label, $matrix) {

    say $label;
    for 0..$matrix.elems - 1 -> $r {
        say sprintf("[ %s ]", $matrix.[$r].join(', '));
    }
}
