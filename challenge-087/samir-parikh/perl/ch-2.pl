#!/usr/local/bin/perl

use v5.10;
use warnings;
use strict;

sub define_matrix {
    open (INPUT, '<', $_[0]) or die "$!: could not open file $_[0]";
    say "Input:";
    my (@line, @matrix, $rows, $columns);
    while (<INPUT>) {
        chomp;
        say $_;
        s/\[ //;
        s/ \]//;
        @line = split / /, $_;
# see https://stackoverflow.com/a/22291537
        push (@matrix, [@line]);
    }
    close (INPUT) or die "$!: could not close file $_[0]";
    $rows    = scalar @matrix;
    $columns = scalar @line;
# see http://perlmeme.org/faqs/perl_thinking/returning.html
# I need to return the scalar variables before the array so that
# they are assigned properly in the main program.  Otherwise,
# the array will "capture" the scalar variables and the scalar
# variables will be undefined.
    return ($rows, $columns, @matrix);
}

sub all_ones {
# see https://stackoverflow.com/a/2305559
    if (@_ == grep { $_ eq '1' } @_) {
        return 1;
    } else {
        return 0;
    }
# assuming that the values of all array elements are either 0 or 1,
# you could also check whether the sum of the elements of the array
# equals the length.  I feel that the method I went with is more
# idomatic, or at least I think it is.
}

sub print_solution {
    my ($rows, $columns, $topleft_column, $topleft_row,
        $bottomright_column, $bottomright_row) = @_;
    for (my $row = 0; $row < $rows; $row++) {
        print "[ ";
        for (my $column = 0; $column < $columns; $column++) {
            if ($row < $topleft_row || $row > $bottomright_row) {
                print "_ ";
            } elsif ($column < $topleft_column || $column > $bottomright_column) {
                print "_ ";
            } else {
                print "1 ";
            }
        }
        print "]\n";
    }
}

# the variables are specifically declared in this order so that
# the scalar variables ($rows, $columns) are defined properly.
# If I put the arracy (@matrix) first, it also "captures" the
# scalar variables leaving $rows and $columns undefined.
# see https://stackoverflow.com/q/55299734 for more information.
my ($num_rows, $num_columns, @matrix) = &define_matrix($ARGV[0]);
my $largest_rectangle_area = 0;
my @largest_rectangle_vertices;
# @largest_rectangle_vertices(topleft_column, topleft_row,
#                             bottomright_column, bottomright_row)

# traverse the matrix
# find top right corner
# start at the top and work your way down
for (my $r = 0; $r < ($num_rows - 1); $r++) {
# start at the left and work your way to the right
    for (my $c = 0; $c < ($num_columns - 1); $c++) {
# find bottom left corner
# start at the far right and work your way left
        for (my $right_column = $num_columns - 1;
             $right_column > $c;
             $right_column--) {
# start at the top and work your way up
            for (my $bottom_row = $num_rows - 1;
                 $bottom_row > $r;
                 $bottom_row--) {
                my $area = ($right_column - $c + 1) *
                           ($bottom_row - $r + 1);
# the next statement doesn't really save that much time but
# no need to check a rectangle whose area is less than one
# that has already been found
                last if ($area < $largest_rectangle_area);
                my @elements;
# slurp all ones and zeros from the rectangle we defined
                for (my $y = $r; $y <= $bottom_row; $y++) {
                    my $rowref = $matrix[$y];
                    push (@elements, @$rowref[$c .. $right_column]);
                }
                if (&all_ones(@elements)) {
                    if ($area > $largest_rectangle_area) {
                        $largest_rectangle_area = $area;
                        @largest_rectangle_vertices = (
                            $c, $r, $right_column, $bottom_row);
                    }   # end if $area
                }       # end if &all_ones
            }           # end for $bottom_row
        }               # end for $right_column
    }                   # end for $c
}                       # end for $r

print "\n";
if ($largest_rectangle_area) {
    say "Largest rectangle found here:";
    &print_solution($num_rows, $num_columns, @largest_rectangle_vertices);
} else {
    say "No rectangle found.";
}
