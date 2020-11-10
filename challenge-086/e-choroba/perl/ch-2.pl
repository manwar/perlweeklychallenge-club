#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package Sudoku;
    sub new {
        my ($class, $sudoku) = @_;
        $sudoku =~ s/\[ | \]//g;
        $sudoku =~ s/_/0/g;
        bless [map [split], split /\n/, $sudoku], $class;
    }

    sub solve {
        my ($self) = @_;
        for my $x (0 .. 8) {
            for my $y (0 .. 8) {
                next if $self->[$y][$x];

                for my $try (1 .. 9) {
                    if ($self->maybe($y, $x, $try)) {
                        $self->[$y][$x] = $try;
                        return 1 if $self->solve;
                    }
                }
                $self->[$y][$x] = 0;
                return
            }
        }
        return 1
    }

    sub maybe {
        my ($self, $y, $x, $try) = @_;
        return 0 if grep $_ == $try, @{ $self->[$y] };
        return 0 if grep $_ == $try, map $self->[$_][$x], 0 .. 8;
        my $x_square = int($x / 3);
        my $y_square = int($y / 3);
        for my $y1 ($y_square * 3 .. $y_square * 3 + 2) {
            for my $x1 ( $x_square * 3 .. $x_square * 3 + 2) {
                return 0 if $self->[$y1][$x1] == $try;
            }
        }
        return 1
    }
}

use Test::More;

my $s = 'Sudoku'->new(<<~ 'SUDOKU');
    [ _ _ _ 2 6 _ 7 _ 1 ]
    [ 6 8 _ _ 7 _ _ 9 _ ]
    [ 1 9 _ _ _ 4 5 _ _ ]
    [ 8 2 _ 1 _ _ _ 4 _ ]
    [ _ _ 4 6 _ 2 9 _ _ ]
    [ _ 5 _ _ _ 3 _ 2 8 ]
    [ _ _ 9 3 _ _ _ 7 4 ]
    [ _ 4 _ _ 5 _ _ 3 6 ]
    [ 7 _ 3 _ 1 8 _ _ _ ]
    SUDOKU

ok $s->solve, 'solvable';
is_deeply $s, [
    [4, 3, 5, 2, 6, 9, 7, 8, 1],
    [6, 8, 2, 5, 7, 1, 4, 9, 3],
    [1, 9, 7, 8, 3, 4, 5, 6, 2],
    [8, 2, 6, 1, 9, 5, 3, 4, 7],
    [3, 7, 4, 6, 8, 2, 9, 1, 5],
    [9, 5, 1, 7, 4, 3, 6, 2, 8],
    [5, 1, 9, 3, 2, 6, 8, 7, 4],
    [2, 4, 8, 9, 5, 7, 1, 3, 6],
    [7, 6, 3, 4, 1, 8, 2, 5, 9]], 'correct';

my $s2 = 'Sudoku'->new(<<~ 'SUDOKU');
    [ 3 _ _ 2 6 _ 7 _ 1 ]
    [ 6 8 _ _ 7 _ _ 9 _ ]
    [ 1 9 _ _ _ 4 5 _ _ ]
    [ 8 2 _ 1 _ _ _ 4 _ ]
    [ _ _ 4 6 _ 2 9 _ _ ]
    [ _ 5 _ _ _ 3 _ 2 8 ]
    [ _ _ 9 3 _ _ _ 7 4 ]
    [ _ 4 _ _ 5 _ _ 3 6 ]
    [ 7 _ 3 _ 1 8 _ _ _ ]
    SUDOKU

ok ! $s2->solve, 'not solvable';

# Additional examples taken from https://sudoku.com/.

my $s3 = 'Sudoku'->new(<<~ 'SUDOKU');
    [ 4 _ _ _ _ 8 _ _ 2 ]
    [ _ _ _ 7 _ _ _ _ _ ]
    [ _ _ _ _ 9 1 _ 7 _ ]
    [ _ 1 _ 5 _ 6 _ _ _ ]
    [ 6 _ _ _ _ 4 _ 9 _ ]
    [ _ 5 _ _ _ _ 8 _ _ ]
    [ 3 4 _ _ _ 2 _ _ 1 ]
    [ 8 _ _ _ 3 _ _ _ 6 ]
    [ _ 2 _ 8 1 _ _ _ _ ]
    SUDOKU
ok $s3->solve, 'hard solvable';
is_deeply $s3, [
    [4, 7, 9, 6, 5, 8, 3, 1, 2],
    [1, 6, 2, 7, 4, 3, 9, 5, 8],
    [5, 3, 8, 2, 9, 1, 6, 7, 4],
    [9, 1, 3, 5, 8, 6, 2, 4, 7],
    [6, 8, 7, 3, 2, 4, 1, 9, 5],
    [2, 5, 4, 1, 7, 9, 8, 6, 3],
    [3, 4, 5, 9, 6, 2, 7, 8, 1],
    [8, 9, 1, 4, 3, 7, 5, 2, 6],
    [7, 2, 6, 8, 1, 5, 4, 3, 9],
], 'hard correct';

my $s4 = 'Sudoku'->new(<<~ 'SUDOKU');
    [ 7 6 _ _ _ _ _ _ _ ]
    [ _ 5 _ _ _ _ 8 2 _ ]
    [ _ _ _ 2 _ 7 _ 4 _ ]
    [ _ _ _ _ 9 6 7 _ _ ]
    [ _ 3 _ _ _ _ _ 1 _ ]
    [ _ _ _ 8 _ _ _ _ _ ]
    [ 2 _ _ _ _ 1 3 _ _ ]
    [ 1 _ _ _ _ _ 9 6 _ ]
    [ _ 7 _ _ _ 9 _ _ 5 ]
    SUDOKU
ok $s4->solve, 'expert solvable';
is_deeply $s4, [
    [7, 6, 2, 9, 8, 4, 5, 3, 1],
    [4, 5, 9, 6, 1, 3, 8, 2, 7],
    [3, 8, 1, 2, 5, 7, 6, 4, 9],
    [8, 2, 4, 1, 9, 6, 7, 5, 3],
    [9, 3, 6, 7, 4, 5, 2, 1, 8],
    [5, 1, 7, 8, 3, 2, 4, 9, 6],
    [2, 9, 8, 5, 6, 1, 3, 7, 4],
    [1, 4, 5, 3, 7, 8, 9, 6, 2],
    [6, 7, 3, 4, 2, 9, 1, 8, 5],
], 'expert correct';

done_testing();
