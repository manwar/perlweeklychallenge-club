#!/usr/local/bin/perl

use v5.10;
use warnings;
use strict;
use List::Util qw(min);

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

# the variables are specifically declared in this order so that
# the scalar variables ($rows, $columns) are defined properly.
# If I put the arracy (@matrix) first, it also "captures" the
# scalar variables leaving $rows and $columns undefined.
# see https://stackoverflow.com/q/55299734 for more information.
my ($rows, $columns, @matrix) = &define_matrix($ARGV[0]);
my $max_square_size = min($rows, $columns);
my $match = 0;

for (   my $square_size = 2;
        $square_size <= $max_square_size;
        $square_size++
        ) {
    for (my $c = 0; $c <= $columns - $square_size; $c++) {
        for (my $r = 0; $r <= $rows - $square_size; $r++) {
# check top left, bottom left, top right and bottom right corners
            if (
                $matrix[$r][$c]                                       == 1 &&
                $matrix[$r + $square_size - 1][$c]                    == 1 &&
                $matrix[$r][$c + $square_size - 1]                    == 1 &&
                $matrix[$r + $square_size - 1][$c + $square_size - 1] == 1
                ) {
                $match++;
                say "Found one square (${square_size}x${square_size}) " .
                "in the given matrix with four corners as 1 " .
                "starts at r=", $r + 1, "; c=", $c + 1, ".";
            }
        }
    }
}

say "Total number of matches found: $match";
