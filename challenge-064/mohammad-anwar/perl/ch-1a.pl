#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use List::Util qw(sum);

is(min_sum_path([[ 1, 2, 3 ],
                 [ 4, 5, 6 ],
                 [ 7, 8, 9 ]],
                 0, 0),
   "1 →  2 →  3 →  6 →  9");

done_testing;

sub min_sum_path {
    my ($matrix, $row, $col, $path) = @_;

    my $paths = {};
    $paths->{join " →  ", @$_} = sum @$_ for find_path($matrix, 0, 0);
    return (sort {  $paths->{$a} <=> $paths->{$b} } keys %$paths)[0];
}

sub find_path {
    my ($matrix, $row, $col, $path) = @_;
    $path = [] unless defined $path;

    my $rows = $#$matrix;
    my $cols = $#{$matrix->[0]};

    # check boundary?
    return if ($row > $rows || $col > $cols);

    my $final_path = [ @$path ];
    push @$final_path, $matrix->[$row][$col];

    # reached bottom right corner?
    return $final_path if ($row == $rows && $col == $cols);

    my @current_path = ();

    # go right if possible.
    push @current_path, find_path($matrix, $row, $col + 1, $final_path);

    # go down if possible.
    push @current_path, find_path($matrix, $row + 1, $col, $final_path);

    return @current_path;
}
