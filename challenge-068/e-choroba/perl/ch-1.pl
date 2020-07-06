#!/usr/bin/perl
use warnings;
use strict;

use PDL;

sub zero_matrix {
    my ($matrix) = @_;
    my $pdl = pdl($matrix);
    return unpdl(andover($pdl->xchg(0,1)) * transpose(andover($pdl)))
}

use Test::More tests => 2;

is_deeply zero_matrix([[1, 0, 1], [1, 1, 1], [1, 1, 1]]),
          [[0, 0, 0],[1, 0, 1],[1, 0, 1]];

is_deeply zero_matrix([[1, 0, 1], [1, 1, 1], [1, 0, 1]]),
          [[0, 0, 0], [1, 0, 1], [0, 0, 0]];
