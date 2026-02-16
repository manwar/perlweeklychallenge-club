#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';
use List::Util qw(all sum);

sub main ($matrix_json) {
    my $matrix = decode_json($matrix_json);

    # Check that the matrix is square
    my $row_length = scalar(@$matrix);
    foreach my $row (@$matrix) {
        if ( scalar(@$row) != $row_length ) {
            die "All rows must have the same length\n";
        }
    }

    foreach my $row_idx ( 0 .. $#$matrix ) {
        if ( sum( @{ $matrix->[$row_idx] } ) ) {
            # This celebrity knows someone
            next;
        }

        # Check if everyone else know this celebrity.
        my $is_celebrity =
          all { $_ == $row_idx or $matrix->[$_][$row_idx] } ( 0 .. $#$matrix );
        if ($is_celebrity) {
            # We have the celebrity
            say $row_idx;
            return;
        }
    }

    # No celebrity is found
    say -1;
}

main(@ARGV);
