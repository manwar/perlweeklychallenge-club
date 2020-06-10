#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply([find_path([[ 1, 2, 3 ],
                      [ 4, 5, 6 ],
                      [ 7, 8, 9 ]],
                      0, 0)],
          [[ 1, 2, 3, 6, 9 ],
           [ 1, 2, 5, 6, 9 ],
           [ 1, 2, 5, 8, 9 ],
           [ 1, 4, 5, 6, 9 ],
           [ 1, 4, 5, 8, 9 ],
           [ 1, 4, 7, 8, 9 ]]);

done_testing;

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
