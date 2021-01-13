#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use Syntax::Construct qw{ // };

use List::Util qw{ max };

sub draw_histogram {
    my @columns = @_;
    my $max = max(@columns);
    my $max_length = length $max;
    for my $y (reverse 1 .. $max) {
        printf "%${max_length}d ", $y;
        say join ' ', map {
            sprintf "%${max_length}s", $columns[$_ - 1] >= $y ? '#' : ' '
        } 1 .. @columns;
    }
    say join ' ', ('_' x $max_length) x (1 + @columns);
    printf "%${max_length}s ", "";
    say join ' ', map sprintf("%${max_length}d", $_), @columns;
}

sub _pop {
    my ($max, $smallest, $columns, $column) = @_;
    my $s = pop @$smallest;
    my $area = $columns->[$s] * ($column - ($smallest->[-1] // -1) - 1);
    $$max = $area if $area > $$max;
}

sub largest_rectangle {
    my @columns = @_;
    my @smallest;
    my $max = 0;
    my $column = 0;
    while ($column <= $#columns) {
        if (! @smallest || $columns[$column] > $columns[ $smallest[-1] ]) {
            push @smallest, $column++;
        } else {
            _pop(\$max, \@smallest, \@columns, $column);
        }
    }
    _pop(\$max, \@smallest, \@columns, $column) while @smallest;
    return $max
}

use Test::More tests => 5;

{
    open my $stdout, '>', \ my $out;
    select $stdout;
    draw_histogram(2, 1, 4, 5, 3, 7);
    is $out, << '__STDOUT__', 'Print Example 1';
7           #
6           #
5       #   #
4     # #   #
3     # # # #
2 #   # # # #
1 # # # # # #
_ _ _ _ _ _ _
  2 1 4 5 3 7
__STDOUT__
}

{
    open my $stdout, '>', \ my $out;
    select $stdout;
    draw_histogram(2, 10);
    is $out, << '__STDOUT__', 'Longer numbers';
10     #
 9     #
 8     #
 7     #
 6     #
 5     #
 4     #
 3     #
 2  #  #
 1  #  #
__ __ __
    2 10
__STDOUT__
}

is largest_rectangle(2, 1, 4, 5, 3, 7), 12, 'Example 1';
is largest_rectangle(3, 2, 3, 5, 7, 5), 15, 'Example 2';

# https://www.geeksforgeeks.org/largest-rectangle-under-histogram/
is largest_rectangle(6, 2, 5, 4, 5, 1, 6), 12, 'Sumit Ghosh';
