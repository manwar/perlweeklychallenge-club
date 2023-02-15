#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use PDL;

sub reshape_matrix($matrix, $r, $c) {
    my $p = pdl($matrix);
    die 'Two dimensional matrix expected' unless $p->ndims == 2;

    return 0 unless $r * $c == $p->getdim(0) * $p->getdim(1);

    return unpdl($p->reshape($c, $r))
}

# Import explicitly, some functions (e.g. float) conflict with PDL's ones.
use Test2::V0 qw{ is plan };
plan 3;

is reshape_matrix([[1, 2], [3, 4]], 1, 4), [[1, 2, 3, 4]], 'Example 1';
is reshape_matrix([[1, 2, 3], [4, 5, 6]], 3, 2),
    [[1, 2], [3, 4], [5, 6]],
    'Example 2';
is reshape_matrix([[1, 2]], 3, 2), 0, 'Example 3';
