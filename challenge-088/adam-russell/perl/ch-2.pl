use strict;
use warnings;
##
# You are given m x n matrix of positive integers.
# Write a script to print spiral matrix as a list.
##
sub print_remove_top{
    my(@matrix) = @_;
    print join(", ", @{$matrix[0]}) . ", ";
    splice(@matrix, 0, 1);
    return @matrix;
}

sub print_remove_right{
    my(@matrix) = @_;
    my @right;
    for my $row (@matrix){
        push @right, $row->[-1];
        my @a = @{$row}[0 .. (@{$row} - 2)];
        $row = \@a;
    }
    print join(", ", @right) . ", ";
    return @matrix;
}

sub print_remove_bottom{
    my(@matrix) = @_;
    print join(", ", reverse(@{$matrix[-1]})) . ", ";
    splice(@matrix, -1);
    return @matrix;
}

sub print_remove_left{
    my(@matrix) = @_;
    my @left;
    for my $row (@matrix){
        push @left, $row->[0];
        my @a = @{$row}[1 .. (@{$row} - 1)];
        $row = \@a;
    }
    print join(", ", reverse(@left)) . ", ";
    return @matrix;
}

sub spiral_print{
    my(@matrix) = @_;
    print "[";
    {
        @matrix = print_remove_top(@matrix) if @matrix;
        @matrix = print_remove_right(@matrix) if @matrix;
        @matrix = print_remove_bottom(@matrix) if @matrix;
        @matrix = print_remove_left(@matrix) if @matrix;
        redo if @matrix;
    }
    print "\b\b]\n";
}

MAIN:{
    spiral_print(
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    );
    spiral_print(
        [ 1,  2,  3,  4],
        [ 5,  6,  7,  8],
        [ 9, 10, 11, 12],
        [13, 14, 15, 16]
    );
}