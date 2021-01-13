#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{min max};

## You are given matrix m x n with 0 and 1.
## 
## Write a script to find the largest rectangle containing 
## only 1. Print 0 if none found.

my @matrices;
push @matrices,
    [
    [ 0, 0, 0, 1, 0, 0 ],
    [ 1, 1, 1, 0, 0, 0 ],
    [ 0, 0, 1, 0, 0, 1 ],
    [ 1, 1, 1, 1, 1, 0 ],
    [ 1, 1, 1, 1, 1, 0 ],
    ];
push @matrices,
    [
    [ 1, 0, 1, 0, 1, 0 ],
    [ 0, 1, 0, 1, 0, 1 ],
    [ 1, 0, 1, 0, 1, 0 ],
    [ 0, 1, 0, 1, 0, 1 ],
    ];
push @matrices,
    [
    [ 0, 0, 0, 1, 1, 1 ],
    [ 1, 1, 1, 1, 1, 1 ],
    [ 0, 0, 1, 0, 0, 1 ],
    [ 0, 0, 1, 1, 1, 1 ],
    [ 0, 0, 1, 1, 1, 1 ],
    ];

# this one is my example. I wanted a rectangle taller than wide
push @matrices,
    [
    [ 0, 0, 1, 1 ],
    [ 0, 0, 1, 1 ],
    [ 0, 0, 1, 1 ],
    [ 0, 0, 1, 1 ],
    [ 0, 0, 1, 1 ],
    [ 0, 0, 1, 1 ],
    [ 0, 0, 1, 1 ],
    [ 0, 0, 1, 1 ],
    ];

for my $matrix (@matrices) {
    say '=' x 20;
    display_matrix($matrix);
    largest_rectangle($matrix);
}

exit;

# $i and $y are the x and y of the upper left corner of the matrix.
# $k and $l are the x and y of the lower right corner. 

# we get the submatrix defined by those corners, convert it to 
# an array and grep for a zero. If so, we go onto the next
sub largest_rectangle ( $matrix ) {
    my $matrix_list = {};
    for my $i ( 0 .. -2 + scalar $matrix->@* ) {
        for my $j ( 0 .. -2 + scalar $matrix->[$i]->@* ) {
            for my $k ( $i + 1 .. -1 + scalar $matrix->@* ) {
                for my $l ( $j + 1 .. -1 + scalar $matrix->[$i]->@* ) {
                    my $submatrix = make_submatrix( $matrix, $i, $j, $k, $l );
                    my $array     = matrix_to_array($submatrix);
                    my $count     = scalar $array->@*;
                    next if grep { /0/ } $array->@*;
                    push $matrix_list->{$count}->@*, $submatrix;
                }
            }
        }
    }
    my $max = max keys $matrix_list->%*;
    if ($max) {
        display_matrix( $matrix_list->{$max}[0] );
    }
    else { say 0 }
    say '';
}

# given a matrix, returns a one-dimentional array 
# with all the values
sub matrix_to_array ($matrix) {
    my $output = [];
    for my $r ( $matrix->@* ) {
        push $output->@*, $r->@*;
    }
    return $output;
}

# given a matrix and the xy coordinates of both the 
# upper left and lower right corners, returns a matrix
# of all entries within
sub make_submatrix ( $matrix, $x1, $y1, $x2, $y2 ) {
    my $output = [];
    my $i      = 0;

    for my $x ( $x1 .. $x2 ) {
        for my $y ( $y1 .. $y2 ) {
            push $output->[$i]->@*, $matrix->[$x][$y];
        }
        $i++;
    }
    return $output;
}

# draws the matrix
sub display_matrix ( $matrix ) {
    for my $r ( $matrix->@* ) {
        say join ' ', $r->@*;
    }
    say '-' x 10;
}
